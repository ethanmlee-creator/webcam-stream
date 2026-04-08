import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PirRecord extends FirestoreRecord {
  PirRecord._(
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
          ? parent.collection('pir')
          : FirebaseFirestore.instance.collectionGroup('pir');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('pir').doc(id);

  static Stream<PirRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => PirRecord.fromSnapshot(s));

  static Future<PirRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => PirRecord.fromSnapshot(s));

  static PirRecord fromSnapshot(DocumentSnapshot snapshot) => PirRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static PirRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      PirRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'PirRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is PirRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createPirRecordData({
  DateTime? createdAt,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'createdAt': createdAt,
    }.withoutNulls,
  );

  return firestoreData;
}

class PirRecordDocumentEquality implements Equality<PirRecord> {
  const PirRecordDocumentEquality();

  @override
  bool equals(PirRecord? e1, PirRecord? e2) {
    return e1?.createdAt == e2?.createdAt;
  }

  @override
  int hash(PirRecord? e) => const ListEquality().hash([e?.createdAt]);

  @override
  bool isValidKey(Object? o) => o is PirRecord;
}
