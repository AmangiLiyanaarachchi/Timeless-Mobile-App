// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timeless/main.dart';
import 'package:timeless/screens/bottom_bar/notifications_screen.dart';

import '../constants/firebase_consts.dart';
import '../models/notification_model.dart';

class NotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void requestNotificationPermissions() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
    } else {}
  }

  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((message) {
      if (Platform.isAndroid) {
        initLocalNotifications(context, message);
        showNotification(message);
      } else {
        showNotification(message);
      }
    });
  }

  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
        Random.secure().nextInt(100000).toString(),
        "High iImportance Notification",
        importance: Importance.max);

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      channel.id.toString(),
      channel.name.toString(),
      channelDescription: "Notification channel",
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
    );

    DarwinNotificationDetails darwinNotificationDetails =
        const DarwinNotificationDetails(
            presentAlert: true, presentBadge: true, presentSound: true);

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);
    Future.delayed(Duration.zero, () {
      localNotificationsPlugin.show(0, message.notification!.title.toString(),
          message.notification!.body.toString(), notificationDetails);
    });
  }

  void initLocalNotifications(
      BuildContext context, RemoteMessage message) async {
    var androidInitialization =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitialization = const DarwinInitializationSettings();
    var initializationSetting = InitializationSettings(
        android: androidInitialization, iOS: iosInitialization);

    await localNotificationsPlugin.initialize(
      initializationSetting,
      onDidReceiveNotificationResponse: (payload) {
        Get.to(NotificationsScreen());
      },
    );
  }

  Future<void> getFcmTokenForCustomer() async {
    await fcm.requestPermission();

    await fcm.getToken().then((token) {
      if (token != null) {
        firestore
            .collection("Customers")
            .doc(auth.currentUser?.uid)
            .set({'token': token}, SetOptions(merge: true));
      }
    });
  }

  Future<void> getFcmTokenForAdmin() async {
    await fcm.requestPermission();

    await fcm.getToken().then((token) {
      if (token != null) {
        firestore
            .collection("Admins")
            .doc(auth.currentUser?.uid)
            .set({'token': token}, SetOptions(merge: true));
      }
    });
  }

  void isTokenRefreshed() async {
    messaging.onTokenRefresh.listen((event) {
      event.toString();
    });
  }

  void sendNotification(String title, String token, String body,
      String targetId, String navId) async {
    var data = {
      'to': token,
      'priority': 'high',
      'notification': {
        'title': title,
        'body': body,
      },
      'data': {
        'id': targetId,
      }
    };

    var res = await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
        body: jsonEncode(data),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization':
              'key=AAAA4NyprNY:APA91bFgerBAwC1EfHQcedkXGn7rP6IxN6ViHLSqoTXws8S5ZaOcBhj3VsPMcX0ODNYLJp4Lq9_13Kzmjri8dmVauwNhGn7wvY1cdguQGzmS6T8VciJadz95exGvJHSDzWKlHSEQRJpv',
        });
    if (res.statusCode != 200) {
      if (kDebugMode) {
        print('Exception:: ${res.statusCode}');
      }
    } else if (res.statusCode == 200) {
      NotificationModel newData = NotificationModel(
        uid: uuid.v1(),
        senderId: auth.currentUser!.uid,
        receiverId: targetId,
        message: body,
        time: DateTime.now(),
        productId: '',
        navigationId: navId,
      );
      await firestore
          .collection("Notifications")
          .doc(newData.uid)
          .set(newData.toMap())
          .then(
            (value) => debugPrint("Notification received"),
          );
      if (kDebugMode) {
        print('sent ${res.body.toString()}');
      }
    }
  }

  Future<void> setUpInteractMessage(BuildContext context) async {
    //App terminated state
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      Get.to(NotificationsScreen());
    }

    //App in backgroud
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      Get.to(NotificationsScreen());
    });
  }
}
