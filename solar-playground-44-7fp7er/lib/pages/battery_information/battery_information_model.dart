import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'battery_information_widget.dart' show BatteryInformationWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BatteryInformationModel
    extends FlutterFlowModel<BatteryInformationWidget> {
  ///  Local state fields for this page.

  dynamic inaALatest;

  dynamic inaBLatest;

  dynamic batteryALatest;

  dynamic batterBLatest;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - getLatestBatteryVoltageA] action in BatteryInformation widget.
  dynamic? battA;
  // Stores action output result for [Custom Action - getLatestBatteryVoltageB] action in BatteryInformation widget.
  dynamic? battB;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
