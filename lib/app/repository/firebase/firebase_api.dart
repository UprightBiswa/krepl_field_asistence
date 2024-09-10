import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../modules/notification/notification_view.dart';
import 'notification_db.dart';
import 'notification_model.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  final notificationTitle = message.notification?.title ?? "No title";
  final notificationBody = message.notification?.body ?? "No body";
  final dataPayload = message.data;

  print('Title: $notificationTitle');
  print('Body: $notificationBody');
  print('Payload: $dataPayload');
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final _tokenKey = 'fcm_token';
  final NotificationDatabase _notificationDatabase = NotificationDatabase();
  final _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications',
    importance: Importance.defaultImportance,
  );

  final _localNotifications = FlutterLocalNotificationsPlugin();
  FirebaseApi() {
    _notificationDatabase.init();
  }
  void handleMessage(RemoteMessage? message) async {
    if (message == null) return;
    final notificationTitle = message.notification?.title ?? "No title";
    final notificationBody = message.notification?.body ?? "No body";

    final newNotification = NotificationModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      notificationAbout: notificationTitle,
      notificationMessage: notificationBody,
      notificationTime: DateTime.now(),
    );
    // Add the new notification to the list
    // notificationsList.add(newNotification);
    await _notificationDatabase.saveNotification(newNotification);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.to(() => const NotificationView(
            showappbar: true,
          ));
    });
  }

  Future initLocalNotifications() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings = InitializationSettings(android: android);
    await _localNotifications.initialize(
      settings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        // Handle the notification response here
        final message = RemoteMessage.fromMap(jsonDecode(response.payload!));
        handleMessage(message);
      },
    );
    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }

  Future<void> initPushNotification() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;
      _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _androidChannel.id,
            _androidChannel.name,
            channelDescription: _androidChannel.description,
            icon: '@mipmap/ic_launcher',
          ),
        ),
        payload: jsonEncode(message.toMap()),
      );
    });
  }

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken(); //
    // Save the FCM token to SharedPreferences
    if (fCMToken != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(_tokenKey, fCMToken);
      print('saved token: $fCMToken');
    }
    print('Token: ${fCMToken!}');
    initPushNotification();
    initLocalNotifications();
  }
}
