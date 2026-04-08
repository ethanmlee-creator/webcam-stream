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

Future<dynamic> getLatestCpuTemp(// #CHANGE removed inputs parameter
    ) async {
  // #CHANGE trailing comma removed
  const String topCollection = 'sensorData';
  const String sensorDoc = 'cpu_temp';
  const String readingsSubcollection = 'cpu_temp_readings';

  dynamic fallbackNoData([String status = 'No Data']) => {
        'temperature_C': -999.0,
        'status': status,
        'timestamp': '',
        'device_id': '',
        'sensor': 'cpu_temp',
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
        .collection(topCollection)
        .doc(sensorDoc)
        .collection(readingsSubcollection);

    QuerySnapshot snap; // #CHANGE removed generic <Map<String,dynamic>>

    // Attempt #1: timestamp ordering
    try {
      snap = await ref.orderBy('timestamp', descending: true).limit(1).get();
    } catch (_) {
      // Attempt #2: doc ID ordering
      snap = await ref
          .orderBy(FieldPath.documentId, descending: true)
          .limit(1)
          .get();
    }

    if (snap.docs.isEmpty) return fallbackNoData();

    final doc = snap.docs.first;
    final raw = doc.data(); // #CHANGE removed generic typing
    final d = (raw is Map ? raw : {}) // #CHANGE safe cast → no generics
        as Map<String, dynamic>;

    final rawTemp = d['temperature_C'];
    final temp = (rawTemp is num) ? rawTemp.toDouble() : -999.0;

    return {
      'temperature_C': temp,
      'status': (d['status'] ?? '').toString(),
      'timestamp': normalizeTimestamp(d['timestamp']),
      'device_id': (d['device_id'] ?? '').toString(),
      'sensor': (d['sensor'] ?? 'cpu_temp').toString(),
      'doc_id': doc.id,
    };
  } catch (e) {
    return fallbackNoData('Error: ${e.toString()}');
  }
}
