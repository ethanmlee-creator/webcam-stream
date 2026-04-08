// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:cloud_firestore/cloud_firestore.dart';

Future<dynamic> getLatestIna219A() async {
  const String topCollection = 'sensorData';
  const String sensorDoc = 'ina219_A';
  const String readingsSubcollection = 'ina219_A_readings';

  dynamic fallbackNoData([String status = 'No Data']) => {
        'bus_voltage_V': -999.0,
        'current_A': -999.0,
        'power_W': -999.0,
        'shunt_voltage_mV': -999.0,
        'soc_estimate': -999.0,
        'status': status,
        'timestamp': '',
        'device_id': '',
        'sensor': 'ina219_A',
        'doc_id': '',
      };

  String normalizeTimestamp(dynamic ts) {
    if (ts == null) return '';
    if (ts is Timestamp) return ts.toDate().toIso8601String();
    if (ts is String) return ts;
    return ts.toString();
  }

  double asDouble(dynamic v, [double fallback = -999.0]) {
    if (v is num) return v.toDouble();
    if (v is String) return double.tryParse(v) ?? fallback;
    return fallback;
  }

  try {
    final ref = FirebaseFirestore.instance
        .collection(topCollection)
        .doc(sensorDoc)
        .collection(readingsSubcollection);

    QuerySnapshot snap;

    // Attempt #1 — timestamp ordering
    try {
      snap = await ref.orderBy('timestamp', descending: true).limit(1).get();
    } catch (_) {
      // Attempt #2 — doc ID ordering
      snap = await ref
          .orderBy(FieldPath.documentId, descending: true)
          .limit(1)
          .get();
    }

    if (snap.docs.isEmpty) return fallbackNoData();

    final doc = snap.docs.first;
    final raw = doc.data();
    final d = (raw is Map ? raw : {}) as Map<String, dynamic>;

    return {
      'bus_voltage_V': asDouble(d['bus_voltage_V']),
      'current_A': asDouble(d['current_A']),
      'power_W': asDouble(d['power_W']),
      'shunt_voltage_mV': asDouble(d['shunt_voltage_mV']),
      'soc_estimate': asDouble(d['soc_estimate']),
      'status': (d['status'] ?? '').toString(),
      'timestamp': normalizeTimestamp(d['timestamp']),
      'device_id': (d['device_id'] ?? '').toString(),
      'sensor': (d['sensor'] ?? 'ina219_A').toString(),
      'doc_id': doc.id,
    };
  } catch (e) {
    return fallbackNoData('Error: ${e.toString()}');
  }
}
