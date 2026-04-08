import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PublicRecord extends FirestoreRecord {
  PublicRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "avgLightLevel" field.
  double? _avgLightLevel;
  double get avgLightLevel => _avgLightLevel ?? 0.0;
  bool hasAvgLightLevel() => _avgLightLevel != null;

  // "lastUpdate" field.
  DateTime? _lastUpdate;
  DateTime? get lastUpdate => _lastUpdate;
  bool hasLastUpdate() => _lastUpdate != null;

  // "lightsActive" field.
  int? _lightsActive;
  int get lightsActive => _lightsActive ?? 0;
  bool hasLightsActive() => _lightsActive != null;

  // "totalAlerts" field.
  int? _totalAlerts;
  int get totalAlerts => _totalAlerts ?? 0;
  bool hasTotalAlerts() => _totalAlerts != null;

  // "totalSensors" field.
  int? _totalSensors;
  int get totalSensors => _totalSensors ?? 0;
  bool hasTotalSensors() => _totalSensors != null;

  void _initializeFields() {
    _avgLightLevel = castToType<double>(snapshotData['avgLightLevel']);
    _lastUpdate = snapshotData['lastUpdate'] as DateTime?;
    _lightsActive = castToType<int>(snapshotData['lightsActive']);
    _totalAlerts = castToType<int>(snapshotData['totalAlerts']);
    _totalSensors = castToType<int>(snapshotData['totalSensors']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('public');

  static Stream<PublicRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => PublicRecord.fromSnapshot(s));

  static Future<PublicRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => PublicRecord.fromSnapshot(s));

  static PublicRecord fromSnapshot(DocumentSnapshot snapshot) => PublicRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static PublicRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      PublicRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'PublicRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is PublicRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createPublicRecordData({
  double? avgLightLevel,
  DateTime? lastUpdate,
  int? lightsActive,
  int? totalAlerts,
  int? totalSensors,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'avgLightLevel': avgLightLevel,
      'lastUpdate': lastUpdate,
      'lightsActive': lightsActive,
      'totalAlerts': totalAlerts,
      'totalSensors': totalSensors,
    }.withoutNulls,
  );

  return firestoreData;
}

class PublicRecordDocumentEquality implements Equality<PublicRecord> {
  const PublicRecordDocumentEquality();

  @override
  bool equals(PublicRecord? e1, PublicRecord? e2) {
    return e1?.avgLightLevel == e2?.avgLightLevel &&
        e1?.lastUpdate == e2?.lastUpdate &&
        e1?.lightsActive == e2?.lightsActive &&
        e1?.totalAlerts == e2?.totalAlerts &&
        e1?.totalSensors == e2?.totalSensors;
  }

  @override
  int hash(PublicRecord? e) => const ListEquality().hash([
        e?.avgLightLevel,
        e?.lastUpdate,
        e?.lightsActive,
        e?.totalAlerts,
        e?.totalSensors
      ]);

  @override
  bool isValidKey(Object? o) => o is PublicRecord;
}
