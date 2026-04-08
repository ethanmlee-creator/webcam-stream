import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class Test1Record extends FirestoreRecord {
  Test1Record._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "test" field.
  String? _test;
  String get test => _test ?? '';
  bool hasTest() => _test != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _test = snapshotData['test'] as String?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('test1')
          : FirebaseFirestore.instance.collectionGroup('test1');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('test1').doc(id);

  static Stream<Test1Record> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => Test1Record.fromSnapshot(s));

  static Future<Test1Record> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => Test1Record.fromSnapshot(s));

  static Test1Record fromSnapshot(DocumentSnapshot snapshot) => Test1Record._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static Test1Record getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      Test1Record._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'Test1Record(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is Test1Record &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createTest1RecordData({
  String? test,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'test': test,
    }.withoutNulls,
  );

  return firestoreData;
}

class Test1RecordDocumentEquality implements Equality<Test1Record> {
  const Test1RecordDocumentEquality();

  @override
  bool equals(Test1Record? e1, Test1Record? e2) {
    return e1?.test == e2?.test;
  }

  @override
  int hash(Test1Record? e) => const ListEquality().hash([e?.test]);

  @override
  bool isValidKey(Object? o) => o is Test1Record;
}
