import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:second_project/home_screen/data/local_notification_services.dart';

class PushNotificationServices {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static Future init() async {
    await messaging.requestPermission();
    String? token = await messaging.getToken();
    log(token ?? '');
    FirebaseMessaging.onBackgroundMessage(handler);
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        LocalNotificationService.showBasicNotification(
          message.notification?.title,
          message.notification?.body,
        );
      },
    );
  }

  static Future<void> handler(message) async {
    await Firebase.initializeApp();
    log(message.notification?.title ?? 'No');
  }
}
