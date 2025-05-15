import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> handler(RemoteMessage message) async {
  log('Background Message :::');
  log('Title ::: ${message.notification?.title}');
  log('Body ::: ${message.notification?.body}');
  log('Payload ::: ${message.data}');
}

Future<void> handlePushNotification(RemoteMessage message) async {
  log('Foreground or Opened App Notification :::');
  log('Title ::: ${message.notification?.title}');
  log('Body ::: ${message.notification?.body}');
  log('Payload ::: ${message.data}');
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();

    // Show notifications when app is in foreground
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    final fcmToken = await _firebaseMessaging.getToken();
    log('fcmToken ::: $fcmToken');

    SharedPreferences pref = await SharedPreferences.getInstance();
    if (fcmToken != null) {
      pref.setString('fcmToken', fcmToken);
    }

    initPushNotification(); // Setup listeners
  }

  void initPushNotification() {
    // Foreground message listener
    FirebaseMessaging.onMessage.listen(handlePushNotification);

    // When app is opened via a notification (from background)
    FirebaseMessaging.onMessageOpenedApp.listen(handlePushNotification);

    // When app is opened from a terminated state via a notification
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        handlePushNotification(message);
      }
    });
  }
}
