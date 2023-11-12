// 20200207 박연우, 아미공 2023 졸프 덕썸니아
// 알림 메시지 구현 코드

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:rxdart/subjects.dart';
// import 'package:timezone/timezone.dart' as tz;
// import 'package:timezone/data/latest.dart' as tz;

class LocalNotificationService {
  LocalNotificationService();

  final _localNotificationService = FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@drawable/ic_stat_announcement');

    /*
    IOSInitializationSettings iosInitializationSettings =
        IOSInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: true,
            requestSoundPermission: true,
            onDidReceiveLocalNotification: _onDidReceiveLocalNotification
        );
    */

    final InitializationSettings settings = InitializationSettings(
      android: androidInitializationSettings,
      // iOS: iosInitializationSettings,
    );

    // await _localNotificationService.initialize(settings,
    //     onSelectNotification: onSelectNotification);
  }

  Future<NotificationDetails> _notificationDetails() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
          'channel_Id', 
          'channel_Name',
          channelDescription: 'description',
          importance: Importance.max,
          priority: Priority.max,
          playSound: true);
    
    // const IOSNotificationDetails iosNotificationDetails =
    //     IOSNotificationDetails();
    
    return NotificationDetails(
        android: androidNotificationDetails, 
        // iOS: iosNotificationDetails
        );
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    final details = await _notificationDetails();
    await _localNotificationService.show(id, title, body, details);
  }

  void _onDidReceiveLocalNotification(
      int id, String? title, String? body, String? keyword) {
    print('id $id');
  }

  void onSelectNotification(String? keyword) {
    print('keyword $keyword');
  }
}
