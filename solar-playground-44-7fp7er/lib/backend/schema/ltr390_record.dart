import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class Ltr390Record extends FirestoreRecord {
  Ltr390Record._(
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
          ? parent.collection('ltr390')
          : FirebaseFirestore.instance.collectionGroup('ltr390');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('ltr390').doc(id);

  static Stream<Ltr390Record> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => Ltr390Record.fromSnapshot(s));

  static Future<Ltr390Record> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => Ltr390Record.fromSnapshot(s));

  static Ltr390Record fromSnapshot(DocumentSnapshot snapshot) => Ltr390Record._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static Ltr390Record getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      Ltr390Record._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'Ltr390Record(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is Ltr390Record &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createLtr390RecordData({
  DateTime? createdAt,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'createdAt': createdAt,
    }.withoutNulls,
  );

  return firestoreData;
}

class Ltr390RecordDocumentEquality implements Equality<Ltr390Record> {
  const Ltr390RecordDocumentEquality();

  @override
  bool equals(Ltr390Record? e1, Ltr390Record? e2) {
    return e1?.createdAt == e2?.createdAt;
  }

  @override
  int hash(Ltr390Record? e) => const ListEquality().hash([e?.createdAt]);

  @override
  bool isValidKey(Object? o) => o is Ltr390Record;
}
