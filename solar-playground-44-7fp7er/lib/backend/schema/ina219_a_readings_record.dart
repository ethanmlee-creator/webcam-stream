import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class Ina219AReadingsRecord extends FirestoreRecord {
  Ina219AReadingsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "bus_voltage_V" field.
  double? _busVoltageV;
  double get busVoltageV => _busVoltageV ?? 0.0;
  bool hasBusVoltageV() => _busVoltageV != null;

  // "current_A" field.
  double? _currentA;
  double get currentA => _currentA ?? 0.0;
  bool hasCurrentA() => _currentA != null;

  // "power_W" field.
  double? _powerW;
  double get powerW => _powerW ?? 0.0;
  bool hasPowerW() => _powerW != null;

  // "shunt_voltage_mV" field.
  double? _shuntVoltageMV;
  double get shuntVoltageMV => _shuntVoltageMV ?? 0.0;
  bool hasShuntVoltageMV() => _shuntVoltageMV != null;

  // "soc_estimate" field.
  double? _socEstimate;
  double get socEstimate => _socEstimate ?? 0.0;
  bool hasSocEstimate() => _socEstimate != null;

  // "device_id" field.
  String? _deviceId;
  String get deviceId => _deviceId ?? '';
  bool hasDeviceId() => _deviceId != null;

  // "timestamp" field.
  DateTime? _timestamp;
  DateTime? get timestamp => _timestamp;
  bool hasTimestamp() => _timestamp != null;

  void _initializeFields() {
    _busVoltageV = castToType<double>(snapshotData['bus_voltage_V']);
    _currentA = castToType<double>(snapshotData['current_A']);
    _powerW = castToType<double>(snapshotData['power_W']);
    _shuntVoltageMV = castToType<double>(snapshotData['shunt_voltage_mV']);
    _socEstimate = castToType<double>(snapshotData['soc_estimate']);
    _deviceId = snapshotData['device_id'] as String?;
    _timestamp = snapshotData['timestamp'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('ina219A_readings');

  static Stream<Ina219AReadingsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => Ina219AReadingsRecord.fromSnapshot(s));

  static Future<Ina219AReadingsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => Ina219AReadingsRecord.fromSnapshot(s));

  static Ina219AReadingsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      Ina219AReadingsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static Ina219AReadingsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      Ina219AReadingsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'Ina219AReadingsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is Ina219AReadingsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createIna219AReadingsRecordData({
  double? busVoltageV,
  double? currentA,
  double? powerW,
  double? shuntVoltageMV,
  double? socEstimate,
  String? deviceId,
  DateTime? timestamp,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'bus_voltage_V': busVoltageV,
      'current_A': currentA,
      'power_W': powerW,
      'shunt_voltage_mV': shuntVoltageMV,
      'soc_estimate': socEstimate,
      'device_id': deviceId,
      'timestamp': timestamp,
    }.withoutNulls,
  );

  return firestoreData;
}

class Ina219AReadingsRecordDocumentEquality
    implements Equality<Ina219AReadingsRecord> {
  const Ina219AReadingsRecordDocumentEquality();

  @override
  bool equals(Ina219AReadingsRecord? e1, Ina219AReadingsRecord? e2) {
    return e1?.busVoltageV == e2?.busVoltageV &&
        e1?.currentA == e2?.currentA &&
        e1?.powerW == e2?.powerW &&
        e1?.shuntVoltageMV == e2?.shuntVoltageMV &&
        e1?.socEstimate == e2?.socEstimate &&
        e1?.deviceId == e2?.deviceId &&
        e1?.timestamp == e2?.timestamp;
  }

  @override
  int hash(Ina219AReadingsRecord? e) => const ListEquality().hash([
        e?.busVoltageV,
        e?.currentA,
        e?.powerW,
        e?.shuntVoltageMV,
        e?.socEstimate,
        e?.deviceId,
        e?.timestamp
      ]);

  @override
  bool isValidKey(Object? o) => o is Ina219AReadingsRecord;
}
