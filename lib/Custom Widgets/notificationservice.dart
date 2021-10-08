import 'dart:ui';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  static final NotificationService _notificationService = NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  NotificationService._internal();

  Future<void> initNotification() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('ic_flutternotification');



    final InitializationSettings initializationSettings =
    InitializationSettings(
        android: initializationSettingsAndroid
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showDailyNotification(int id, String title, String body, int seconds) async {
    await flutterLocalNotificationsPlugin.periodicallyShow(
      id,
      title,
      body,
      RepeatInterval.daily,
      const NotificationDetails(
        android: AndroidNotificationDetails(
            '1',
            '2',
            importance: Importance.max,
            priority: Priority.max,
            icon: '@drawable/ic_flutternotification'

        ),


      ),
      androidAllowWhileIdle: true,
    );
  }
  Future<void> ShowTimedNotification(int id, String title, String body, int seconds) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.now(tz.local).add(Duration(seconds: seconds)),
      const NotificationDetails(
        android: AndroidNotificationDetails(
            '3',
            '4',
            importance: Importance.max,
            priority: Priority.max,
            icon: '@drawable/ic_flutternotification'

        ),


      ),
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
    );
  }
  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}