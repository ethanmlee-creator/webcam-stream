// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
import 'package:firebase_messaging/firebase_messaging.dart';

Future<String?> getFCMTokenForWeb() async {
  try {
    final token = await FirebaseMessaging.instance.getToken(
      vapidKey:
          'BBbvx7GeYJ_bW5wQMT-lkssT_qyrNJ8-elwgRcyue4VYNUmXxcf2GbscwJHW5Lz-0wDP6bC45A8aNiTknKIp4pE',
    );
    return token;
  } catch (_) {
    return null;
  }
}
