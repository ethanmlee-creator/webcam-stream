import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/auth/firebase_auth/auth_util.dart';

String? formatEventTime(String? createdlocal) {
  try {
    final dt = DateTime.parse(createdlocal!);
    final local = dt.toLocal();
    return "${local.month.toString().padLeft(2, '0')}/"
        "${local.day.toString().padLeft(2, '0')}/"
        "${local.year} "
        "${(local.hour % 12 == 0 ? 12 : local.hour % 12).toString().padLeft(2, '0')}:"
        "${local.minute.toString().padLeft(2, '0')}:"
        "${local.second.toString().padLeft(2, '0')} "
        "${local.hour >= 12 ? 'PM' : 'AM'}";
  } catch (_) {
    return createdlocal;
  }
}
