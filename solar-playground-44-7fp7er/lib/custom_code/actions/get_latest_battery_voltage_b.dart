// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'index.dart'; // Imports other custom actions

import 'package:cloud_firestore/cloud_firestore.dart';

Future<dynamic> getLatestBatteryVoltageB() async {
  const String batteryCollection = 'batteries';
  const String batteryDoc = 'batteryB';
  const String readingsSubcollection = 'battB_percent';

  dynamic fallbackNoData([String status = 'No Data']) => {
        'voltage': -999.0,
        'soc': 0,
        'status': status,
        'timestamp': '',
        'device_id': '',
        'battery_id': 'B',
        'doc_id': '',
      };

  String normalizeTimestamp(dynamic ts) {
    if (ts == null) return '';
    if (ts is Timestamp) return ts.toDate().toIso8601String();
    if (ts is String) return ts;
    return ts.toString();
  }

  try {
    final ref = FirebaseFirestore.instance
        .collection(batteryCollection)
        .doc(batteryDoc)
        .collection(readingsSubcollection);

    QuerySnapshot snap;

    try {
      snap = await ref.orderBy('timestamp', descending: true).limit(1).get();
    } catch (_) {
      snap = await ref
          .orderBy(FieldPath.documentId, descending: true)
          .limit(1)
          .get();
    }

    if (snap.docs.isEmpty) return fallbackNoData();

    final doc = snap.docs.first;
    final raw = doc.data();
    final d = (raw is Map ? raw : {}) as Map<String, dynamic>;

    final rawVoltage = d['voltage'];
    final voltage = (rawVoltage is num) ? rawVoltage.toDouble() : -999.0;
    final rawSoc = d['soc'];
    final soc = (rawSoc is num) ? rawSoc.toInt() : 0;

    return {
      'voltage': voltage,
      'soc': soc,
      'status': (d['status'] ?? '').toString(),
      'timestamp': normalizeTimestamp(d['timestamp']),
      'device_id': (d['device_id'] ?? '').toString(),
      'battery_id': (d['battery_id'] ?? 'B').toString(),
      'doc_id': doc.id,
    };
  } catch (e) {
    return fallbackNoData('Error: ${e.toString()}');
  }
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
