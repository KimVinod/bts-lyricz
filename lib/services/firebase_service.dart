import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../firebase_options.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    "high_importance_channel", //id
    "BTS Related Notification Channel", //title
    importance: Importance.high,
    playSound: true
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );
}

class FirebaseService {
  static void _setupCrashlytics(bool isRelease) {
    if(isRelease) {
      FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    } else {
      FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
      FirebaseCrashlytics.instance.deleteUnsentReports();
    }
  }

  static void _setupAnalytics(bool isRelease) => FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(isRelease);

  static Future<void> _setupMessaging() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true
    );
  }

  static Future<void> setup({required bool isRelease}) async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    _setupCrashlytics(isRelease);
    _setupAnalytics(isRelease);
    await _setupMessaging();
  }

  static void init() {
    const initializationSettingsAndroid = AndroidInitializationSettings("@mipmap/ic_launcher");
    const initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if(notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              playSound: true,
            ),
          ),
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    });
  }
}