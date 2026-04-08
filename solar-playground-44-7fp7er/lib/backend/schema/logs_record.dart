import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class LogsRecord extends FirestoreRecord {
  LogsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "battery_id" field.
  String? _batteryId;
  String get batteryId => _batteryId ?? '';
  bool hasBatteryId() => _batteryId != null;

  // "device_id" field.
  String? _deviceId;
  String get deviceId => _deviceId ?? '';
  bool hasDeviceId() => _deviceId != null;

  // "soc" field.
  double? _soc;
  double get soc => _soc ?? 0.0;
  bool hasSoc() => _soc != null;

  // "timestamp" field.
  DateTime? _timestamp;
  DateTime? get timestamp => _timestamp;
  bool hasTimestamp() => _timestamp != null;

  // "voltage" field.
  double? _voltage;
  double get voltage => _voltage ?? 0.0;
  bool hasVoltage() => _voltage != null;

  void _initializeFields() {
    _batteryId = snapshotData['battery_id'] as String?;
    _deviceId = snapshotData['device_id'] as String?;
    _soc = castToType<double>(snapshotData['soc']);
    _timestamp = snapshotData['timestamp'] as DateTime?;
    _voltage = castToType<double>(snapshotData['voltage']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('logs');

  static Stream<LogsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => LogsRecord.fromSnapshot(s));

  static Future<LogsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => LogsRecord.fromSnapshot(s));

  static LogsRecord fromSnapshot(DocumentSnapshot snapshot) => LogsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static LogsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      LogsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'LogsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is LogsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createLogsRecordData({
  String? batteryId,
  String? deviceId,
  double? soc,
  DateTime? timestamp,
  double? voltage,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'battery_id': batteryId,
      'device_id': deviceId,
      'soc': soc,
      'timestamp': timestamp,
      'voltage': voltage,
    }.withoutNulls,
  );

  return firestoreData;
}

class LogsRecordDocumentEquality implements Equality<LogsRecord> {
  const LogsRecordDocumentEquality();

  @override
  bool equals(LogsRecord? e1, LogsRecord? e2) {
    return e1?.batteryId == e2?.batteryId &&
        e1?.deviceId == e2?.deviceId &&
        e1?.soc == e2?.soc &&
        e1?.timestamp == e2?.timestamp &&
        e1?.voltage == e2?.voltage;
  }

  @override
  int hash(LogsRecord? e) => const ListEquality()
      .hash([e?.batteryId, e?.deviceId, e?.soc, e?.timestamp, e?.voltage]);

  @override
  bool isValidKey(Object? o) => o is LogsRecord;
}
