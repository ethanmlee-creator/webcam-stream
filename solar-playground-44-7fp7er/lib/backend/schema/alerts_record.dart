import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AlertsRecord extends FirestoreRecord {
  AlertsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "acknowledged" field.
  bool? _acknowledged;
  bool get acknowledged => _acknowledged ?? false;
  bool hasAcknowledged() => _acknowledged != null;

  // "message" field.
  String? _message;
  String get message => _message ?? '';
  bool hasMessage() => _message != null;

  // "severity" field.
  String? _severity;
  String get severity => _severity ?? '';
  bool hasSeverity() => _severity != null;

  // "timestamp" field.
  DateTime? _timestamp;
  DateTime? get timestamp => _timestamp;
  bool hasTimestamp() => _timestamp != null;

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  bool hasType() => _type != null;

  void _initializeFields() {
    _acknowledged = snapshotData['acknowledged'] as bool?;
    _message = snapshotData['message'] as String?;
    _severity = snapshotData['severity'] as String?;
    _timestamp = snapshotData['timestamp'] as DateTime?;
    _type = snapshotData['type'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('alerts');

  static Stream<AlertsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => AlertsRecord.fromSnapshot(s));

  static Future<AlertsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => AlertsRecord.fromSnapshot(s));

  static AlertsRecord fromSnapshot(DocumentSnapshot snapshot) => AlertsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static AlertsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      AlertsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'AlertsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is AlertsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createAlertsRecordData({
  bool? acknowledged,
  String? message,
  String? severity,
  DateTime? timestamp,
  String? type,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'acknowledged': acknowledged,
      'message': message,
      'severity': severity,
      'timestamp': timestamp,
      'type': type,
    }.withoutNulls,
  );

  return firestoreData;
}

class AlertsRecordDocumentEquality implements Equality<AlertsRecord> {
  const AlertsRecordDocumentEquality();

  @override
  bool equals(AlertsRecord? e1, AlertsRecord? e2) {
    return e1?.acknowledged == e2?.acknowledged &&
        e1?.message == e2?.message &&
        e1?.severity == e2?.severity &&
        e1?.timestamp == e2?.timestamp &&
        e1?.type == e2?.type;
  }

  @override
  int hash(AlertsRecord? e) => const ListEquality()
      .hash([e?.acknowledged, e?.message, e?.severity, e?.timestamp, e?.type]);

  @override
  bool isValidKey(Object? o) => o is AlertsRecord;
}
