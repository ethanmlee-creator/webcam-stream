import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class Ina219BRecord extends FirestoreRecord {
  Ina219BRecord._(
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
          ? parent.collection('ina219_B')
          : FirebaseFirestore.instance.collectionGroup('ina219_B');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('ina219_B').doc(id);

  static Stream<Ina219BRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => Ina219BRecord.fromSnapshot(s));

  static Future<Ina219BRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => Ina219BRecord.fromSnapshot(s));

  static Ina219BRecord fromSnapshot(DocumentSnapshot snapshot) =>
      Ina219BRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static Ina219BRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      Ina219BRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'Ina219BRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is Ina219BRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createIna219BRecordData({
  DateTime? createdAt,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'createdAt': createdAt,
    }.withoutNulls,
  );

  return firestoreData;
}

class Ina219BRecordDocumentEquality implements Equality<Ina219BRecord> {
  const Ina219BRecordDocumentEquality();

  @override
  bool equals(Ina219BRecord? e1, Ina219BRecord? e2) {
    return e1?.createdAt == e2?.createdAt;
  }

  @override
  int hash(Ina219BRecord? e) => const ListEquality().hash([e?.createdAt]);

  @override
  bool isValidKey(Object? o) => o is Ina219BRecord;
}
