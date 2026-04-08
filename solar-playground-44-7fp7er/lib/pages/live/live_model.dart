import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/index.dart';
import 'live_widget.dart' show LiveWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LiveModel extends FlutterFlowModel<LiveWidget> {
  ///  Local state fields for this page.

  String? liveKitToken;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (GetLiveKitToken)] action in Button widget.
  ApiCallResponse? tokenResult;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
