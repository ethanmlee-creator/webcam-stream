import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PirReadingsRecord extends FirestoreRecord {
  PirReadingsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "device_id" field.
  String? _deviceId;
  String get deviceId => _deviceId ?? '';
  bool hasDeviceId() => _deviceId != null;

  // "duration_sec" field.
  double? _durationSec;
  double get durationSec => _durationSec ?? 0.0;
  bool hasDurationSec() => _durationSec != null;

  // "motion_cycle" field.
  bool? _motionCycle;
  bool get motionCycle => _motionCycle ?? false;
  bool hasMotionCycle() => _motionCycle != null;

  // "motion_ended" field.
  DateTime? _motionEnded;
  DateTime? get motionEnded => _motionEnded;
  bool hasMotionEnded() => _motionEnded != null;

  // "motion_started" field.
  DateTime? _motionStarted;
  DateTime? get motionStarted => _motionStarted;
  bool hasMotionStarted() => _motionStarted != null;

  // "timestamp" field.
  DateTime? _timestamp;
  DateTime? get timestamp => _timestamp;
  bool hasTimestamp() => _timestamp != null;

  void _initializeFields() {
    _deviceId = snapshotData['device_id'] as String?;
    _durationSec = castToType<double>(snapshotData['duration_sec']);
    _motionCycle = snapshotData['motion_cycle'] as bool?;
    _motionEnded = snapshotData['motion_ended'] as DateTime?;
    _motionStarted = snapshotData['motion_started'] as DateTime?;
    _timestamp = snapshotData['timestamp'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('pir_readings');

  static Stream<PirReadingsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => PirReadingsRecord.fromSnapshot(s));

  static Future<PirReadingsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => PirReadingsRecord.fromSnapshot(s));

  static PirReadingsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      PirReadingsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static PirReadingsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      PirReadingsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'PirReadingsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is PirReadingsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createPirReadingsRecordData({
  String? deviceId,
  double? durationSec,
  bool? motionCycle,
  DateTime? motionEnded,
  DateTime? motionStarted,
  DateTime? timestamp,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'device_id': deviceId,
      'duration_sec': durationSec,
      'motion_cycle': motionCycle,
      'motion_ended': motionEnded,
      'motion_started': motionStarted,
      'timestamp': timestamp,
    }.withoutNulls,
  );

  return firestoreData;
}

class PirReadingsRecordDocumentEquality implements Equality<PirReadingsRecord> {
  const PirReadingsRecordDocumentEquality();

  @override
  bool equals(PirReadingsRecord? e1, PirReadingsRecord? e2) {
    return e1?.deviceId == e2?.deviceId &&
        e1?.durationSec == e2?.durationSec &&
        e1?.motionCycle == e2?.motionCycle &&
        e1?.motionEnded == e2?.motionEnded &&
        e1?.motionStarted == e2?.motionStarted &&
        e1?.timestamp == e2?.timestamp;
  }

  @override
  int hash(PirReadingsRecord? e) => const ListEquality().hash([
        e?.deviceId,
        e?.durationSec,
        e?.motionCycle,
        e?.motionEnded,
        e?.motionStarted,
        e?.timestamp
      ]);

  @override
  bool isValidKey(Object? o) => o is PirReadingsRecord;
}
