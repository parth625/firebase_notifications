import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:new_app/second_screen.dart';

class NotificationServices {
  /// Creating an instance of firebase messaging
  FirebaseMessaging messaging = FirebaseMessaging.instance;

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

  void handleMessageTap(BuildContext context) {
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SecondScreen()),
      );
    });
  }

  Future<void> handleTerminatedMessageTap(BuildContext context) async {
    RemoteMessage? message = await messaging.getInitialMessage();

    if (message != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SecondScreen()),
      );
    }
  }

  void firebaseInit(BuildContext context) {}
}
