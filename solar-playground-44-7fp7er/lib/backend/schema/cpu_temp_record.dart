import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CpuTempRecord extends FirestoreRecord {
  CpuTempRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "createdAt" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _createdAt = snapshotData['createdAt'] as DateTime?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('cpu_temp')
          : FirebaseFirestore.instance.collectionGroup('cpu_temp');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('cpu_temp').doc(id);

  static Stream<CpuTempRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => CpuTempRecord.fromSnapshot(s));

  static Future<CpuTempRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => CpuTempRecord.fromSnapshot(s));

  static CpuTempRecord fromSnapshot(DocumentSnapshot snapshot) =>
      CpuTempRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static CpuTempRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      CpuTempRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'CpuTempRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is CpuTempRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createCpuTempRecordData({
  DateTime? createdAt,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'createdAt': createdAt,
    }.withoutNulls,
  );

  return firestoreData;
}

class CpuTempRecordDocumentEquality implements Equality<CpuTempRecord> {
  const CpuTempRecordDocumentEquality();

  @override
  bool equals(CpuTempRecord? e1, CpuTempRecord? e2) {
    return e1?.createdAt == e2?.createdAt;
  }

  @override
  int hash(CpuTempRecord? e) => const ListEquality().hash([e?.createdAt]);

  @override
  bool isValidKey(Object? o) => o is CpuTempRecord;
}
