import 'dart:convert';
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:new_app/services/navigation_service.dart';
import 'package:new_app/pages/screen_one.dart';
import 'package:new_app/pages/screen_two.dart';
import 'package:new_app/pages/second_screen.dart';

class NotificationServices {
  /// Creating an instance of firebase messaging
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  /// Local notification for display notification
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails(
        'high_importance_notification',
        'High Importance Notification',
        importance: Importance.max,
        priority: Priority.high,
      );

  late final NotificationDetails notificationDetails = NotificationDetails(
    android: androidNotificationDetails,
  );

  /// Requesting the permission from the user
  Future<void> requestNotificationPermissions() async {
    NotificationSettings settings = await messaging.requestPermission(
      announcement: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log('User grant permission.');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      log('User granted provisional permission');
    } else {
      log('User declined permission');
    }
  }

  /// Getting the FCM Token from the device
  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();
    return token!;
  }

  /// Check if the token is changes
  void isTokenRefresh() {
    messaging.onTokenRefresh.listen((event) {
      event.toString();
      log('refresh');
    });
  }

  /// Navigate when user taps on notification in background/terminated
  void handleMessageTap() {
    FirebaseMessaging.onMessageOpenedApp.listen((message) {

        handleNavigation(message);
    });
  }

  /// To Show notification in terminated state
  Future<void> handleTerminatedMessageTap() async {
    RemoteMessage? message = await messaging.getInitialMessage();

    if (message != null) {
      handleNavigation(message);
    }
  }

  /// Initialize local notification to show the notification
  Future<void> initLocalNotifications(BuildContext context) async {
    final AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    InitializationSettings settings = InitializationSettings(
      android: androidInitializationSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (response) {
        if (response.payload == null) {
          return;
        }

        final Map<String, dynamic> data = jsonDecode(response.payload!);
        handleNavigationFromData(data);
      },
    );
  }

  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification == null) {
        return;
      }

      flutterLocalNotificationsPlugin.show(
        0,
        message.notification?.title,
        message.notification?.body,
        notificationDetails,
        payload: jsonEncode(message.data),
      );
    });
  }

  void handleNavigation(RemoteMessage message) {
    handleNavigationFromData(message.data, message.notification);
  }

  void handleNavigationFromData(
    Map<String, dynamic> data, [
    RemoteNotification? notification,
  ]) {
    // var data = message.data;

    if (data.containsKey('name') && data.containsKey('number')) {
      navigatorKey.currentState?.push(
        MaterialPageRoute(
          builder: (_) => ScreenOne(name: data['name'], number: data['number']),
        ),
      );
    } else if (data.containsKey('name') &&
        data.containsKey('age') &&
        data.containsKey('email') &&
        data.containsKey('image')) {
      // );
      navigatorKey.currentState?.push(
        MaterialPageRoute(
          builder: (context) => ScreenTwo(
            name: data['name'],
            age: data['age'],
            email: data['email'],
            image: data['image'],
          ),
        ),
      );
    } else {
      navigatorKey.currentState?.push(
        MaterialPageRoute(
          builder: (_) => SecondScreen(
            title: notification?.title,
            body: notification?.body,
          ),
        ),
      );
    }
  }
}
