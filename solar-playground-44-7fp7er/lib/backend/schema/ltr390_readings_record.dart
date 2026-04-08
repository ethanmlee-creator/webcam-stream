import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class Ltr390ReadingsRecord extends FirestoreRecord {
  Ltr390ReadingsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "device_id" field.
  String? _deviceId;
  String get deviceId => _deviceId ?? '';
  bool hasDeviceId() => _deviceId != null;

  // "light_condition" field.
  String? _lightCondition;
  String get lightCondition => _lightCondition ?? '';
  bool hasLightCondition() => _lightCondition != null;

  // "lux" field.
  double? _lux;
  double get lux => _lux ?? 0.0;
  bool hasLux() => _lux != null;

  // "uv_raw" field.
  double? _uvRaw;
  double get uvRaw => _uvRaw ?? 0.0;
  bool hasUvRaw() => _uvRaw != null;

  // "timestamp" field.
  DateTime? _timestamp;
  DateTime? get timestamp => _timestamp;
  bool hasTimestamp() => _timestamp != null;

  void _initializeFields() {
    _deviceId = snapshotData['device_id'] as String?;
    _lightCondition = snapshotData['light_condition'] as String?;
    _lux = castToType<double>(snapshotData['lux']);
    _uvRaw = castToType<double>(snapshotData['uv_raw']);
    _timestamp = snapshotData['timestamp'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('ltr390_readings');

  static Stream<Ltr390ReadingsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => Ltr390ReadingsRecord.fromSnapshot(s));

  static Future<Ltr390ReadingsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => Ltr390ReadingsRecord.fromSnapshot(s));

  static Ltr390ReadingsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      Ltr390ReadingsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static Ltr390ReadingsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      Ltr390ReadingsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'Ltr390ReadingsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is Ltr390ReadingsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createLtr390ReadingsRecordData({
  String? deviceId,
  String? lightCondition,
  double? lux,
  double? uvRaw,
  DateTime? timestamp,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'device_id': deviceId,
      'light_condition': lightCondition,
      'lux': lux,
      'uv_raw': uvRaw,
      'timestamp': timestamp,
    }.withoutNulls,
  );

  return firestoreData;
}

class Ltr390ReadingsRecordDocumentEquality
    implements Equality<Ltr390ReadingsRecord> {
  const Ltr390ReadingsRecordDocumentEquality();

  @override
  bool equals(Ltr390ReadingsRecord? e1, Ltr390ReadingsRecord? e2) {
    return e1?.deviceId == e2?.deviceId &&
        e1?.lightCondition == e2?.lightCondition &&
        e1?.lux == e2?.lux &&
        e1?.uvRaw == e2?.uvRaw &&
        e1?.timestamp == e2?.timestamp;
  }

  @override
  int hash(Ltr390ReadingsRecord? e) => const ListEquality()
      .hash([e?.deviceId, e?.lightCondition, e?.lux, e?.uvRaw, e?.timestamp]);

  @override
  bool isValidKey(Object? o) => o is Ltr390ReadingsRecord;
}
