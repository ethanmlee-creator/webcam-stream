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

Future<dynamic> getLatestLtr390() async {
  const String topCollection = 'sensorData';
  const String sensorDoc = 'ltr390';
  const String readingsSubcollection = 'ltr390_readings';

  dynamic fallbackNoData([String status = 'No Data']) => {
        'lux': -999.0,
        'uv_raw': -999.0,
        'light_condition': status,
        'timestamp': '',
        'device_id': '',
        'sensor': 'ltr390',
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
    final raw = doc.data();
    final d = (raw is Map ? raw : {}) as Map<String, dynamic>;

    return {
      'lux': asDouble(d['lux']),
      'uv_raw': asDouble(d['uv_raw']),
      'light_condition': (d['light_condition'] ?? '').toString(),
      'timestamp': normalizeTimestamp(d['timestamp']),
      'device_id': (d['device_id'] ?? '').toString(),
      'sensor': (d['sensor'] ?? 'ltr390').toString(),
      'doc_id': doc.id,
    };
  } catch (e) {
    return fallbackNoData('Error: ${e.toString()}');
  }
}
