import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    if (Platform.isIOS) {
      await messaging.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }

    // Initialize Local Notifications
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    
    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );
    
    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    
    await localNotificationsPlugin.initialize(settings: initializationSettings);

    String? token = await messaging.getToken();

    print("FCM Token:");
    print(token);

    FirebaseMessaging.onMessage.listen((message) {
      print(message.notification?.title);
      print(message.notification?.body);
      _showLocalNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print("Notification clicked");
    });

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        print("Opened from terminated state");
      }
    });
  }

  Future<void> _showLocalNotification(RemoteMessage message) async {
    if (message.notification == null) return;

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      importance: Importance.max,
      priority: Priority.high, 
      icon: '@mipmap/ic_launcher',
    );
    
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );
    
    await localNotificationsPlugin.show(
      id: message.notification.hashCode,
      title: message.notification?.title,
      body: message.notification?.body,
      notificationDetails: platformChannelSpecifics,
    );
  }
}