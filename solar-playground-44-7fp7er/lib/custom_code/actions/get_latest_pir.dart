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

Future<dynamic> getLatestPir() async {
  const String topCollection = 'sensorData';
  const String sensorDoc = 'pir';
  const String readingsSubcollection = 'pir_readings';

  dynamic fallbackNoData([String status = 'No Data']) => {
        'duration_sec': -999.0,
        'motion_cycle': false,
        'motion_started': '',
        'motion_ended': '',
        'status': status,
        'timestamp': '',
        'device_id': '',
        'sensor': 'pir',
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

  bool asBool(dynamic v, [bool fallback = false]) {
    if (v is bool) return v;
    if (v is num) return v != 0;
    if (v is String) {
      final s = v.toLowerCase().trim();
      if (s == 'true' || s == '1' || s == 'yes') return true;
      if (s == 'false' || s == '0' || s == 'no') return false;
    }
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
      'duration_sec': asDouble(d['duration_sec']),
      'motion_cycle': asBool(d['motion_cycle']),
      'motion_started': (d['motion_started'] ?? '').toString(),
      'motion_ended': (d['motion_ended'] ?? '').toString(),
      'status': (d['status'] ?? '').toString(),
      'timestamp': normalizeTimestamp(d['timestamp']),
      'device_id': (d['device_id'] ?? '').toString(),
      'sensor': (d['sensor'] ?? 'pir').toString(),
      'doc_id': doc.id,
    };
  } catch (e) {
    return fallbackNoData('Error: ${e.toString()}');
  }
}
