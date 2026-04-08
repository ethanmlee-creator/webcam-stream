import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'sensor_data_widget.dart' show SensorDataWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SensorDataModel extends FlutterFlowModel<SensorDataWidget> {
  ///  Local state fields for this page.

  dynamic cpuTempLatest;

  dynamic inaALatest;

  dynamic inaBLatest;

  dynamic ltrLatest;

  dynamic pirLatest;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - getLatestCpuTemp] action in sensorData widget.
  dynamic? cpuOut;
  // Stores action output result for [Custom Action - getLatestIna219A] action in sensorData widget.
  dynamic? inaAout;
  // Stores action output result for [Custom Action - getLatestIna219B] action in sensorData widget.
  dynamic? inaBout;
  // Stores action output result for [Custom Action - getLatestLtr390] action in sensorData widget.
  dynamic? ltrout;
  // Stores action output result for [Custom Action - getLatestPir] action in sensorData widget.
  dynamic? pirout;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
