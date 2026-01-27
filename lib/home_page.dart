import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:new_app/notification_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  NotificationServices notificationServices = NotificationServices();
  @override
  void initState() {
    notificationServices.requestNotificationPermissions();
    // notificationServices.isTokenRefresh();
    notificationServices.firebaseInit(context);
    notificationServices.getDeviceToken().then((value) {
      log('Token: $value');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Home Page', ),
      ),
    );
  }
}
