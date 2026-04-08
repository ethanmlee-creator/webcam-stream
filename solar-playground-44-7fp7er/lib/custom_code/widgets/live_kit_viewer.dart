// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:livekit_client/livekit_client.dart';

class LiveKitViewer extends StatefulWidget {
  const LiveKitViewer({
    super.key,
    required this.livekitUrl,
    required this.token,
    this.width,
    this.height,
  });

  final String livekitUrl;
  final String token;
  final double? width;
  final double? height;

  @override
  State<LiveKitViewer> createState() => _LiveKitViewerState();
}

class _LiveKitViewerState extends State<LiveKitViewer> {
  Room? _room;
  EventsListener<RoomEvent>? _listener;
  RemoteVideoTrack? _videoTrack;

  @override
  void initState() {
    super.initState();
    _connect();
  }

  Future<void> _connect() async {
    final room = Room();
    await room.connect(widget.livekitUrl, widget.token);

    final listener = room.createListener();
    listener.on<TrackSubscribedEvent>((event) {
      final track = event.track;
      if (track is RemoteVideoTrack) {
        setState(() {
          _videoTrack = track;
        });
      }
    });

    setState(() {
      _room = room;
      _listener = listener;
    });
  }

  @override
  void dispose() {
    _listener?.dispose();
    _room?.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final content = _videoTrack == null
        ? const Center(child: Text('Waiting for video...'))
        : VideoTrackRenderer(_videoTrack!);

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: content,
    );
  }
}
