import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class RolesRecord extends FirestoreRecord {
  RolesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "canAssignRoles" field.
  bool? _canAssignRoles;
  bool get canAssignRoles => _canAssignRoles ?? false;
  bool hasCanAssignRoles() => _canAssignRoles != null;

  // "canDeleteAny" field.
  bool? _canDeleteAny;
  bool get canDeleteAny => _canDeleteAny ?? false;
  bool hasCanDeleteAny() => _canDeleteAny != null;

  // "canEditOwn" field.
  bool? _canEditOwn;
  bool get canEditOwn => _canEditOwn ?? false;
  bool hasCanEditOwn() => _canEditOwn != null;

  // "canManageUsers" field.
  bool? _canManageUsers;
  bool get canManageUsers => _canManageUsers ?? false;
  bool hasCanManageUsers() => _canManageUsers != null;

  // "canViewAll" field.
  bool? _canViewAll;
  bool get canViewAll => _canViewAll ?? false;
  bool hasCanViewAll() => _canViewAll != null;

  void _initializeFields() {
    _canAssignRoles = snapshotData['canAssignRoles'] as bool?;
    _canDeleteAny = snapshotData['canDeleteAny'] as bool?;
    _canEditOwn = snapshotData['canEditOwn'] as bool?;
    _canManageUsers = snapshotData['canManageUsers'] as bool?;
    _canViewAll = snapshotData['canViewAll'] as bool?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('roles');

  static Stream<RolesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => RolesRecord.fromSnapshot(s));

  static Future<RolesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => RolesRecord.fromSnapshot(s));

  static RolesRecord fromSnapshot(DocumentSnapshot snapshot) => RolesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static RolesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      RolesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'RolesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is RolesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createRolesRecordData({
  bool? canAssignRoles,
  bool? canDeleteAny,
  bool? canEditOwn,
  bool? canManageUsers,
  bool? canViewAll,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'canAssignRoles': canAssignRoles,
      'canDeleteAny': canDeleteAny,
      'canEditOwn': canEditOwn,
      'canManageUsers': canManageUsers,
      'canViewAll': canViewAll,
    }.withoutNulls,
  );

  return firestoreData;
}

class RolesRecordDocumentEquality implements Equality<RolesRecord> {
  const RolesRecordDocumentEquality();

  @override
  bool equals(RolesRecord? e1, RolesRecord? e2) {
    return e1?.canAssignRoles == e2?.canAssignRoles &&
        e1?.canDeleteAny == e2?.canDeleteAny &&
        e1?.canEditOwn == e2?.canEditOwn &&
        e1?.canManageUsers == e2?.canManageUsers &&
        e1?.canViewAll == e2?.canViewAll;
  }

  @override
  int hash(RolesRecord? e) => const ListEquality().hash([
        e?.canAssignRoles,
        e?.canDeleteAny,
        e?.canEditOwn,
        e?.canManageUsers,
        e?.canViewAll
      ]);

  @override
  bool isValidKey(Object? o) => o is RolesRecord;
}
