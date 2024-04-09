import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  const NotificationService._();

  ///
  static final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

  ///
  static const AndroidNotificationChannel _androidNotificationChannel =
      AndroidNotificationChannel('high_importance_channel', 'high_importance_channel', description: 'description', importance: Importance.max);

  ///
  static NotificationDetails _notificationDetails() {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        _androidNotificationChannel.id,
        _androidNotificationChannel.name,
        channelDescription: _androidNotificationChannel.description,
        importance: Importance.max,
        priority: Priority.max,
        icon: '@mipmap/ic_launcher',
      ),
      iOS: const DarwinNotificationDetails(),
    );
  }

  ///
  static Future<void> initializeNotification() async {
    const androidInitializationSettings = AndroidInitializationSettings('@mipmap/ic_launcher');

    await _notificationsPlugin.initialize(
      const InitializationSettings(android: androidInitializationSettings, iOS: DarwinInitializationSettings()),
    );
  }

  ///
  static void onMessage(RemoteMessage message) {
    final notification = message.notification;
    final androidNotification = message.notification?.android;
    final appleNotification = message.notification?.apple;

    if (notification == null) {
      return;
    }

    if (androidNotification != null || appleNotification != null) {
      _notificationsPlugin.show(notification.hashCode, notification.title, notification.body, _notificationDetails());
    }
  }

  ///
  static void onMessageOpenedApp(BuildContext context, RemoteMessage message) {
    final notification = message.notification;
    final androidNotification = message.notification?.android;
    final appleNotification = message.notification?.apple;

    if (notification == null) {
      return;
    }

    if (androidNotification != null || appleNotification != null) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(notification.title ?? 'No Title'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text(notification.body ?? 'No Body')],
            ),
          ),
        ),
      );
    }
  }
}
