import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class Ina219ARecord extends FirestoreRecord {
  Ina219ARecord._(
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
          ? parent.collection('ina219_A')
          : FirebaseFirestore.instance.collectionGroup('ina219_A');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('ina219_A').doc(id);

  static Stream<Ina219ARecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => Ina219ARecord.fromSnapshot(s));

  static Future<Ina219ARecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => Ina219ARecord.fromSnapshot(s));

  static Ina219ARecord fromSnapshot(DocumentSnapshot snapshot) =>
      Ina219ARecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static Ina219ARecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      Ina219ARecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'Ina219ARecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is Ina219ARecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createIna219ARecordData({
  DateTime? createdAt,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'createdAt': createdAt,
    }.withoutNulls,
  );

  return firestoreData;
}

class Ina219ARecordDocumentEquality implements Equality<Ina219ARecord> {
  const Ina219ARecordDocumentEquality();

  @override
  bool equals(Ina219ARecord? e1, Ina219ARecord? e2) {
    return e1?.createdAt == e2?.createdAt;
  }

  @override
  int hash(Ina219ARecord? e) => const ListEquality().hash([e?.createdAt]);

  @override
  bool isValidKey(Object? o) => o is Ina219ARecord;
}
