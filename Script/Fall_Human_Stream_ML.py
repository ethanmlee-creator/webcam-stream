# -*- coding: utf-8 -*-
"""
Created on Wed Mar 18 17:44:17 2026

@author: ethan
"""

"""
Pi 4: RTMPS Livestream + Person Gate + Fall Detection + H.264 Clip Upload

Behavior:
- Streams to backend through ffmpeg RTMPS
- Person model runs first
- If person detected:
    * can trigger a PERSON clip upload
    * then fall model runs
- If fall detected:
    * can trigger a FALL clip upload
    * fall cooldown is preserved
- Clips are recorded with correct playback speed (frame-count based)
"""

import os
import time
import platform
import threading
import subprocess
from datetime import datetime

import cv2
import requests
from ultralytics import YOLO

# ----------------------- Config -----------------------
# Person gate model
PERSON_MODEL = "yolov8n.pt"
PERSON_CLASS_ID = 0
PERSON_IMGSZ = 416
PERSON_BASE_CONF = 0.40
PERSON_CONF_TRIGGER = 0.8

# Fall model
FALL_MODEL = "/home/gceja/Desktop/SolarPlaygroundPi/ml_scripts/best.pt"  # change if needed
FALL_CLASS_ID = 0
FALL_IMGSZ = 416
FALL_BASE_CONF = 0.01
FALL_CONF_TRIGGER = 0.3
REQUIRE_FALL_CONSEC_FRAMES = 1

# Camera (Pi)
SOURCE = 0
REQ_W = 640
REQ_H = 480
REQ_FPS = 24

# Stream settings
RTMPS_URL = "rtmps://webcam-stream-d4cttylu.rtmp.livekit.cloud/x/NthuXzhPNuiN"

# Inference sizing / throttling
INFER_W = 640
INFER_H = 360
ML_MAX_FPS = 4.0  # throttle when idle/not recording

# Clip settings
CLIP_DURATION_SEC = 3.0

# Cooldowns
PERSON_COOLDOWN_SEC = 360.0
FALL_COOLDOWN_SEC = 60.0  # keep cooldown for fall detection

# Save location
EVENTS_DIR = "/home/gceja/Desktop/SolarPlaygroundPi/events_human"

# Backend
BACKEND_BASE_URL = "https://webcam-stream-ea5w.onrender.com"
EVENT_UPLOAD_URL = f"{BACKEND_BASE_URL}/events/upload"
DEVICE_ID = "pi-01"

# Event types
PERSON_EVENT_TYPE = "human-present"
FALL_EVENT_TYPE = "person-fall"

AUTH_EMAIL = "ethanmlee@msn.com"
AUTH_PASSWORD = "EL000244"
# ------------------------------------------------------


def ensure_events_dir():
    os.makedirs(EVENTS_DIR, exist_ok=True)


def ensure_ffmpeg_available():
    try:
        subprocess.run(["ffmpeg", "-version"], capture_output=True, check=True)
    except Exception as e:
        raise RuntimeError(
            "ffmpeg not found. Install on Pi with:\n"
            "sudo apt-get update && sudo apt-get install -y ffmpeg"
        ) from e


def open_source(source):
    sysname = platform.system()
    if sysname == "Windows":
        backends = [cv2.CAP_DSHOW, cv2.CAP_MSMF, cv2.CAP_FFMPEG]
    elif sysname == "Darwin":
        backends = [cv2.CAP_AVFOUNDATION, cv2.CAP_FFMPEG]
    else:
        backends = [cv2.CAP_V4L2, cv2.CAP_FFMPEG, cv2.CAP_GSTREAMER]

    src = int(source) if isinstance(source, str) and source.isdigit() else source

    for backend in backends:
        cap = cv2.VideoCapture(src, backend)
        if cap.isOpened():
            cap.set(cv2.CAP_PROP_FRAME_WIDTH, REQ_W)
            cap.set(cv2.CAP_PROP_FRAME_HEIGHT, REQ_H)
            cap.set(cv2.CAP_PROP_FPS, REQ_FPS)
            cap.set(cv2.CAP_PROP_BUFFERSIZE, 1)
            return cap
        cap.release()
    return None


def fetch_jwt():
    resp = requests.post(
        f"{BACKEND_BASE_URL}/auth/login",
        json={"email": AUTH_EMAIL, "password": AUTH_PASSWORD},
        timeout=10,
    )
    resp.raise_for_status()
    return resp.json()["token"]


def upload_clip(filepath, jwt_token, duration_sec, event_type):
    with open(filepath, "rb") as f:
        resp = requests.post(
            EVENT_UPLOAD_URL,
            headers={"Authorization": f"Bearer {jwt_token}"},
            files={"file": (os.path.basename(filepath), f, "video/mp4")},
            data={
                "event_type": event_type,
                "device_id": DEVICE_ID,
                "duration_seconds": duration_sec,
            },
            timeout=60,
        )
    resp.raise_for_status()


def convert_to_h264_ffmpeg(src_path: str) -> str:
    base, _ = os.path.splitext(src_path)
    out_path = f"{base}_h264.mp4"

    cmd = [
        "ffmpeg",
        "-y",
        "-i", src_path,
        "-c:v", "libx264",
        "-preset", "veryfast",
        "-crf", "23",
        "-pix_fmt", "yuv420p",
        "-c:a", "aac",
        "-b:a", "128k",
        out_path,
    ]
    result = subprocess.run(cmd, capture_output=True)
    if result.returncode != 0 or not os.path.exists(out_path):
        print("[WARN] ffmpeg conversion failed; uploading original file.")
        return src_path
    return out_path


def best_conf_from_det(det) -> float:
    if not det or len(det) == 0:
        return 0.0
    try:
        return max((box.conf.item() for box in det[0].boxes), default=0.0)
    except Exception:
        return 0.0


def start_ffmpeg_stream(w, h, fps, rtmps_url):
    fps_int = int(round(fps)) if fps and fps > 1 else REQ_FPS

    cmd = [
        "ffmpeg",
        "-loglevel", "error",
        "-f", "rawvideo",
        "-pix_fmt", "bgr24",
        "-s", f"{w}x{h}",
        "-r", str(fps_int),
        "-i", "-",
        "-an",
        "-c:v", "libx264",
        "-preset", "ultrafast",
        "-tune", "zerolatency",
        "-bf", "0",
        "-pix_fmt", "yuv420p",
        "-profile:v", "baseline",
        "-g", "60",
        "-b:v", "1500k",
        "-maxrate", "1500k",
        "-bufsize", "3000k",
        "-f", "flv",
        rtmps_url,
    ]
    return subprocess.Popen(cmd, stdin=subprocess.PIPE)


class SharedFrame:
    def __init__(self):
        self._lock = threading.Lock()
        self._frame = None
        self._ts = 0.0

    def set(self, frame, ts):
        with self._lock:
            self._frame = frame
            self._ts = ts

    def get(self):
        with self._lock:
            if self._frame is None:
                return None, 0.0
            return self._frame.copy(), self._ts


def capture_and_stream_loop(cap, ffmpeg_proc, shared: SharedFrame, stop_event: threading.Event):
    while not stop_event.is_set():
        ok, frame = cap.read()
        if not ok:
            print("[WARN] Camera read failed.")
            stop_event.set()
            break

        ts = time.time()

        try:
            ffmpeg_proc.stdin.write(frame.tobytes())
        except BrokenPipeError:
            print("[ERROR] ffmpeg pipe broke.")
            stop_event.set()
            break
        except Exception as e:
            print(f"[ERROR] ffmpeg write error: {e}")
            stop_event.set()
            break

        shared.set(frame, ts)


def save_and_upload_clip(current_path, jwt_token, event_type):
    try:
        print(f"[INFO] Saved clip: {current_path}. Converting to H.264...")
        h264_path = convert_to_h264_ffmpeg(current_path)
        print(f"[INFO] Uploading: {h264_path} as {event_type}")
        upload_clip(h264_path, jwt_token, CLIP_DURATION_SEC, event_type)
        print(f"[INFO] Uploaded {h264_path}")

        if h264_path != current_path and os.path.exists(h264_path):
            os.remove(h264_path)

    except requests.HTTPError as e:
        if e.response is not None and e.response.status_code == 401:
            print("[WARN] JWT expired. Refreshing and retrying upload...")
            jwt_token = fetch_jwt()
            h264_path = convert_to_h264_ffmpeg(current_path)
            upload_clip(h264_path, jwt_token, CLIP_DURATION_SEC, event_type)
            print(f"[INFO] Re-uploaded {h264_path}")
            if h264_path != current_path and os.path.exists(h264_path):
                os.remove(h264_path)
        else:
            print(f"[ERROR] Upload failed: {e}")
    except Exception as e:
        print(f"[ERROR] Upload error: {e}")

    return jwt_token


def ml_loop(shared: SharedFrame, stop_event: threading.Event, actual_fps: float):
    print("[INFO] Loading person model...")
    person_model = YOLO(PERSON_MODEL)

    print("[INFO] Loading fall model...")
    fall_model = YOLO(FALL_MODEL)

    print("[INFO] Fetching JWT for uploads...")
    jwt_token = fetch_jwt()

    ensure_events_dir()

    fourcc = cv2.VideoWriter_fourcc(*"mp4v")
    fps_for_clip = float(actual_fps) if actual_fps and actual_fps > 1 else float(REQ_FPS)

    # Recording state
    recording = False
    recording_type = None  # "person" or "fall"
    writer = None
    current_path = None

    target_frames = 0
    frames_written = 0
    last_written_ts = -1.0

    # Cooldowns
    person_cooldown_until = 0.0
    fall_cooldown_until = 0.0

    # Fall state
    fall_consec = 0

    # Throttle
    min_dt = (1.0 / ML_MAX_FPS) if ML_MAX_FPS and ML_MAX_FPS > 0 else 0.0
    last_ml_ts = 0.0

    print(f"[INFO] ML thread running. Clip FPS={fps_for_clip:.2f}, duration={CLIP_DURATION_SEC:.2f}s")

    try:
        while not stop_event.is_set():
            frame, ts = shared.get()
            if frame is None:
                time.sleep(0.01)
                continue

            now = time.time()

            # Recording section
            if recording and writer:
                if ts != last_written_ts:
                    writer.write(frame)
                    last_written_ts = ts
                    frames_written += 1

                if frames_written >= target_frames:
                    writer.release()
                    writer = None

                    finished_type = recording_type
                    finished_path = current_path

                    recording = False
                    recording_type = None
                    current_path = None

                    if finished_type == "person":
                        person_cooldown_until = time.time() + PERSON_COOLDOWN_SEC
                        jwt_token = save_and_upload_clip(finished_path, jwt_token, PERSON_EVENT_TYPE)
                    elif finished_type == "fall":
                        fall_cooldown_until = time.time() + FALL_COOLDOWN_SEC
                        jwt_token = save_and_upload_clip(finished_path, jwt_token, FALL_EVENT_TYPE)

                continue

            # Idle ML throttle
            if min_dt > 0 and (now - last_ml_ts) < min_dt:
                time.sleep(0.005)
                continue
            last_ml_ts = now

            small = cv2.resize(frame, (INFER_W, INFER_H), interpolation=cv2.INTER_AREA)

            # ----------------------------
            # Stage 1: Person gate
            # ----------------------------
            person_det = person_model.predict(
                source=small,
                imgsz=PERSON_IMGSZ,
                conf=PERSON_BASE_CONF,
                classes=[PERSON_CLASS_ID],
                verbose=False,
            )
            person_best = best_conf_from_det(person_det)
            person_detected = person_best >= PERSON_CONF_TRIGGER
            
            fall_best = 0.0  # ← this needs to come first
            
            # NOW add the debug print here ↓
            print(f"[DEBUG] person_best={person_best:.2f} | fall_best={fall_best:.2f} | fall_consec={fall_consec}")
            
          

            # ----------------------------
            # Stage 2: Fall detection only if person present
            # ----------------------------
            
            if person_detected:
                fall_det = fall_model.predict(
                   source=frame,   # ← full resolution frame
                   imgsz=FALL_IMGSZ,
                   conf=FALL_BASE_CONF,
                   classes=[FALL_CLASS_ID],
                   verbose=False,
               )
                fall_best = best_conf_from_det(fall_det)
            
                # DEBUG PRINT
                print(f"[FALL] conf={fall_best:.3f} | threshold={FALL_CONF_TRIGGER} | consec={fall_consec}")
            
                if fall_best >= FALL_CONF_TRIGGER:
                    fall_consec += 1
                else:
                    fall_consec = 0
            else:
                fall_consec = 0

            fall_confirmed = fall_consec >= REQUIRE_FALL_CONSEC_FRAMES

            # ----------------------------
            # Trigger logic
            # Priority: fall first, then person
            # ----------------------------
            trigger_type = None
            trigger_prefix = None

            if fall_confirmed and now >= fall_cooldown_until:
                trigger_type = "fall"
                trigger_prefix = "fall_clip"
            elif person_detected and now >= person_cooldown_until:
                trigger_type = "person"
                trigger_prefix = "person_clip"

            if trigger_type is not None:
                ts_str = datetime.now().strftime("%Y%m%d_%H%M%S")
                filename = f"{trigger_prefix}_{ts_str}.mp4"
                current_path = os.path.join(EVENTS_DIR, filename)

                target_frames = max(1, int(round(fps_for_clip * CLIP_DURATION_SEC)))
                frames_written = 0
                last_written_ts = -1.0

                writer = cv2.VideoWriter(
                    current_path,
                    fourcc,
                    fps_for_clip,
                    (frame.shape[1], frame.shape[0]),
                )

                if not writer.isOpened():
                    try:
                        writer.release()
                    except Exception:
                        pass
                    writer = None
                    current_path = None
                    print(f"[{ts_str}] Failed to open VideoWriter")
                else:
                    recording = True
                    recording_type = trigger_type

                    if trigger_type == "fall":
                        print(
                            f"[{ts_str}] FALL trigger "
                            f"(person={person_best:.2f}, fall={fall_best:.2f}, consec={fall_consec}) "
                            f"-> recording {current_path} ({target_frames} frames)"
                        )
                    else:
                        print(
                            f"[{ts_str}] PERSON trigger "
                            f"(person={person_best:.2f}) "
                            f"-> recording {current_path} ({target_frames} frames)"
                        )

            time.sleep(0.001)

    finally:
        if writer:
            writer.release()


def main():
    if platform.system() == "Windows":
        print("[WARN] This script is intended for Raspberry Pi / Linux.")

    ensure_ffmpeg_available()
    ensure_events_dir()

    print("[INFO] Opening camera...")
    cap = open_source(SOURCE)
    if cap is None:
        raise RuntimeError("Unable to open camera source.")

    actual_fps = cap.get(cv2.CAP_PROP_FPS) or REQ_FPS or 24
    frame_w = int(cap.get(cv2.CAP_PROP_FRAME_WIDTH)) or REQ_W
    frame_h = int(cap.get(cv2.CAP_PROP_FRAME_HEIGHT)) or REQ_H

    print(f"[INFO] Camera: {frame_w}x{frame_h} @ {actual_fps:.1f} fps")
    print("[INFO] Starting ffmpeg livestream to backend...")
    ffmpeg_proc = start_ffmpeg_stream(frame_w, frame_h, actual_fps, RTMPS_URL)

    shared = SharedFrame()
    stop_event = threading.Event()

    t_stream = threading.Thread(
        target=capture_and_stream_loop,
        args=(cap, ffmpeg_proc, shared, stop_event),
        daemon=True,
    )
    t_ml = threading.Thread(
        target=ml_loop,
        args=(shared, stop_event, float(actual_fps)),
        daemon=True,
    )

    print("[INFO] Starting threads...")
    t_stream.start()
    t_ml.start()

    try:
        while not stop_event.is_set():
            time.sleep(0.2)
    except KeyboardInterrupt:
        pass
    finally:
        print("[INFO] Shutting down...")
        stop_event.set()

        try:
            cap.release()
        except Exception:
            pass

        try:
            if ffmpeg_proc and ffmpeg_proc.stdin:
                ffmpeg_proc.stdin.close()
        except Exception:
            pass

        try:
            if ffmpeg_proc:
                ffmpeg_proc.terminate()
        except Exception:
            pass


if __name__ == "__main__":
    main()
