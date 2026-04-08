import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

class GetEventsCall {
  static Future<ApiCallResponse> call({
    String? token = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetEvents',
      apiUrl: 'https://webcam-stream-ea5w.onrender.com/events',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${token}',
        'Content-Type': 'application/json',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? items(dynamic response) => getJsonField(
        response,
        r'''$.items''',
        true,
      ) as List?;
  static dynamic eventType(dynamic response) => getJsonField(
        response,
        r'''$.items[:].event_type''',
      );
  static dynamic createdAt(dynamic response) => getJsonField(
        response,
        r'''$.items[:].created_at''',
      );
  static dynamic createdLocal(dynamic response) => getJsonField(
        response,
        r'''$.items[:].created_local''',
      );
  static dynamic url(dynamic response) => getJsonField(
        response,
        r'''$.items[:].url''',
      );
  static dynamic id(dynamic response) => getJsonField(
        response,
        r'''$.items[:].id''',
      );
}

class GetLiveKitTokenCall {
  static Future<ApiCallResponse> call({
    String? token = '',
    String? room = 'null',
    bool? publish,
  }) async {
    final ffApiRequestBody = '''
{
  "room": "${escapeStringForJson(room)}",
  "identity": "ff-viewer",
  "publish": ${publish}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'GetLiveKitToken',
      apiUrl: 'https://webcam-stream-ea5w.onrender.com/webrtc/token',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${token}',
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static dynamic token(dynamic response) => getJsonField(
        response,
        r'''$.token''',
      );
}

class AckNotificationReceivedCall {
  static Future<ApiCallResponse> call({
    String? token = '',
  }) async {
    final ffApiRequestBody = '''
{
  "notification_id": "[notification_id]"
}
''';
    return ApiManager.instance.makeApiCall(
      callName: 'AckNotificationReceived',
      apiUrl: 'https://webcam-stream-ea5w.onrender.com/notifications/received',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  if (item is DocumentReference) {
    return item.path;
  }
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}

String? escapeStringForJson(String? input) {
  if (input == null) {
    return null;
  }
  return input
      .replaceAll('\\', '\\\\')
      .replaceAll('"', '\\"')
      .replaceAll('\n', '\\n')
      .replaceAll('\t', '\\t');
}
