import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CpuTempReadingsRecord extends FirestoreRecord {
  CpuTempReadingsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "device_id" field.
  String? _deviceId;
  String get deviceId => _deviceId ?? '';
  bool hasDeviceId() => _deviceId != null;

  // "sensor" field.
  String? _sensor;
  String get sensor => _sensor ?? '';
  bool hasSensor() => _sensor != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "temperature_C" field.
  double? _temperatureC;
  double get temperatureC => _temperatureC ?? 0.0;
  bool hasTemperatureC() => _temperatureC != null;

  // "timestamp" field.
  DateTime? _timestamp;
  DateTime? get timestamp => _timestamp;
  bool hasTimestamp() => _timestamp != null;

  void _initializeFields() {
    _deviceId = snapshotData['device_id'] as String?;
    _sensor = snapshotData['sensor'] as String?;
    _status = snapshotData['status'] as String?;
    _temperatureC = castToType<double>(snapshotData['temperature_C']);
    _timestamp = snapshotData['timestamp'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('cpu_temp_readings');

  static Stream<CpuTempReadingsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => CpuTempReadingsRecord.fromSnapshot(s));

  static Future<CpuTempReadingsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => CpuTempReadingsRecord.fromSnapshot(s));

  static CpuTempReadingsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      CpuTempReadingsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static CpuTempReadingsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      CpuTempReadingsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'CpuTempReadingsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is CpuTempReadingsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createCpuTempReadingsRecordData({
  String? deviceId,
  String? sensor,
  String? status,
  double? temperatureC,
  DateTime? timestamp,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'device_id': deviceId,
      'sensor': sensor,
      'status': status,
      'temperature_C': temperatureC,
      'timestamp': timestamp,
    }.withoutNulls,
  );

  return firestoreData;
}

class CpuTempReadingsRecordDocumentEquality
    implements Equality<CpuTempReadingsRecord> {
  const CpuTempReadingsRecordDocumentEquality();

  @override
  bool equals(CpuTempReadingsRecord? e1, CpuTempReadingsRecord? e2) {
    return e1?.deviceId == e2?.deviceId &&
        e1?.sensor == e2?.sensor &&
        e1?.status == e2?.status &&
        e1?.temperatureC == e2?.temperatureC &&
        e1?.timestamp == e2?.timestamp;
  }

  @override
  int hash(CpuTempReadingsRecord? e) => const ListEquality()
      .hash([e?.deviceId, e?.sensor, e?.status, e?.temperatureC, e?.timestamp]);

  @override
  bool isValidKey(Object? o) => o is CpuTempReadingsRecord;
}
