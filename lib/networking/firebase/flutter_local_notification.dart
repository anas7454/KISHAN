import 'package:constructo_worker/networking/firebase/notification_navigation_service.dart';
import 'package:constructo_worker/utils/common/debug_utils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static const String androidChannelId = 'constructochannelId';
  static const String androidChannelName = 'Constructo Notifications';
  static const String androidChannelDescription =
      'Default notification channel for constructo app';

  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// Initialize the notification service
  static Future<void> initialize() async {
    // Android channel setup
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      androidChannelId,
      androidChannelName,
      description: androidChannelDescription,
      importance: Importance.high,
      playSound: true, // realme - oppo
    );

    final androidPlugin = _notificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    if (androidPlugin != null) {
      await androidPlugin.createNotificationChannel(channel);
    }

    // Initialization settings for both platforms
    final initializationSettings = InitializationSettings(
      android: const AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: const DarwinInitializationSettings(
        requestSoundPermission: true,
        requestBadgePermission: true,
        requestAlertPermission: true,
      ),
    );

    // Initialize plugin with safe onClick handler
    await _notificationsPlugin.initialize(
      settings: initializationSettings,
      onDidReceiveNotificationResponse: (payload) async {
        await NotificationNavigationService.handlePayload(payload.payload);
      },
    );
  }

  /// Display a notification safely (foreground & background)
  static Future<void> display(RemoteMessage message) async {
    try {
      final notification = message.notification;
      final String title =
          notification?.title ?? message.data['title']?.toString() ?? "";
      final String body =
          notification?.body ?? message.data['body']?.toString() ?? "";

      if (title.trim().isEmpty && body.trim().isEmpty) return;

      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      final notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          androidChannelId,
          androidChannelName,
          channelDescription: androidChannelDescription,
          importance: Importance.high,
          priority: Priority.high,
          playSound: true,
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      );

      printDebugCustom("Displaying foreground notification...");
      await _notificationsPlugin.show(
        id: id,
        title: title.isEmpty ? 'Constructo' : title,
        body: body,
        notificationDetails: notificationDetails,
        payload: NotificationNavigationService.payloadFromMessage(message),
      );
    } catch (e) {
      printDebugCustom("Foreground Notification Crash Error: $e");
    }
  }
}

/// Fetch FCM token safely
Future<String?> getToken() async {
  try {
    String fcmtoken = await FirebaseMessaging.instance.getToken() ?? "";
    printDebugCustom("run fcm token -->$fcmtoken");
    return fcmtoken;
  } catch (e) {
    printDebugCustom('FCM Token error: $e');
    return null;
  }
}
