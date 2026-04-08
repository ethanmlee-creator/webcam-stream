import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SensorDataRecord extends FirestoreRecord {
  SensorDataRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "sensorName" field.
  String? _sensorName;
  String get sensorName => _sensorName ?? '';
  bool hasSensorName() => _sensorName != null;

  // "createdAt" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  void _initializeFields() {
    _sensorName = snapshotData['sensorName'] as String?;
    _createdAt = snapshotData['createdAt'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('sensorData');

  static Stream<SensorDataRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => SensorDataRecord.fromSnapshot(s));

  static Future<SensorDataRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => SensorDataRecord.fromSnapshot(s));

  static SensorDataRecord fromSnapshot(DocumentSnapshot snapshot) =>
      SensorDataRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static SensorDataRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      SensorDataRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'SensorDataRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is SensorDataRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createSensorDataRecordData({
  String? sensorName,
  DateTime? createdAt,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'sensorName': sensorName,
      'createdAt': createdAt,
    }.withoutNulls,
  );

  return firestoreData;
}

class SensorDataRecordDocumentEquality implements Equality<SensorDataRecord> {
  const SensorDataRecordDocumentEquality();

  @override
  bool equals(SensorDataRecord? e1, SensorDataRecord? e2) {
    return e1?.sensorName == e2?.sensorName && e1?.createdAt == e2?.createdAt;
  }

  @override
  int hash(SensorDataRecord? e) =>
      const ListEquality().hash([e?.sensorName, e?.createdAt]);

  @override
  bool isValidKey(Object? o) => o is SensorDataRecord;
}
