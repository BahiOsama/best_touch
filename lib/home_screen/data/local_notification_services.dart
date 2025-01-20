import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static onTap(NotificationResponse notificationResponse) {}
  static Future init() async {
    flutterLocalNotificationsPlugin.initialize(
        onDidReceiveBackgroundNotificationResponse: onTap,
        onDidReceiveNotificationResponse: onTap,
        const InitializationSettings(
          android: AndroidInitializationSettings('@mipmap/ic_launcher'),
          iOS: DarwinInitializationSettings(),
        ));
  }

  static void showBasicNotification(String? title, String? body) async {
    NotificationDetails details = const NotificationDetails(
      android: AndroidNotificationDetails('a', 'b',
          playSound: true, importance: Importance.high, priority: Priority.max),
    );
    await flutterLocalNotificationsPlugin.show(1, title, body, details);
  }
}
// dont forget to enable mopile notification
