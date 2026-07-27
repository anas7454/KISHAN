import 'dart:convert';
import 'package:constructo_worker/networking/extensions/api_helper.dart';
import 'package:constructo_worker/routes/app_routes.dart';
import 'package:constructo_worker/utils/common/debug_utils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationNavigationService {
  static Future<void> handleRemoteMessage(RemoteMessage? message) async {
    if (message == null) return;
    // await handleData(message.data);
  }

  static Future<void> handlePayload(String? payload) async {
    if (payload == null || payload.trim().isEmpty) return;

    try {
      final decoded = jsonDecode(payload);
      if (decoded is Map) {
        // await handleData(decoded.cast<String, dynamic>());
      }
    } catch (e) {
      printDebugCustom("Notification payload parse error -> $e");
    }
  }

  // static Future<void> handleData(Map<String, dynamic> data) async {
  //   final String matchId = _matchIdFromData(data);
  //   if (matchId.isEmpty) return;

  //   await AppRoutes.matchSectionTabsScreen(matchId, _statusFromData(data));
  // }

  static String payloadFromMessage(RemoteMessage message) {
    return jsonEncode(message.data);
  }
}
