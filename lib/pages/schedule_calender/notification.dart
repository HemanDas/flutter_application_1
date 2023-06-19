import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationApi {
  NotificationApi();
  static final _notification = FlutterLocalNotificationsPlugin();
  Future<void> initialize() async {
    tz.initializeTimeZones();
    const AndroidInitializationSettings amdroidInitializationSettings =
        AndroidInitializationSettings("@mipmap/fitnex");
    final InitializationSettings settings =
        InitializationSettings(android: amdroidInitializationSettings);
    await _notification.initialize(settings);
  }

  Future<NotificationDetails> _notificationDetails() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails("channel_id", "channel_name",
            channelDescription: 'description',
            importance: Importance.max,
            priority: Priority.high,
            playSound: true);
    return NotificationDetails(android: androidNotificationDetails);
  }

  // Future<void> showNotification({
  //   required String title,
  //   required String body,
  // }) async {
  //   final details = await _notificationDetails();
  //   await _notification.show(0, title, body, details);
  // }

  Future<void> showscheduledNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    final details = await _notificationDetails();
    await _notification.periodicallyShow(
        id, title, body, RepeatInterval.daily, details);
  }
}
