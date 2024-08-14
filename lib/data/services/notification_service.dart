import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decordash/features/chat/screens/chat_screen.dart';
import 'package:decordash/utils/logging/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;

const channel = AndroidNotificationChannel(
    'high_importance_channel', 'Hign Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.high,
    playSound: true);

class NotificationsService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void _initLocalNotification() {
    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestCriticalPermission: true,
      requestSoundPermission: true,
    );

    const initializationSettings =
        InitializationSettings(android: androidSettings, iOS: iosSettings);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (response) {
      debugPrint(response.payload.toString());
    });
  }

  Future<void> _showLocalNotification(RemoteMessage message) async {
    final styleInformation = BigTextStyleInformation(
      message.notification!.body.toString(),
      htmlFormatBigText: true,
      contentTitle: message.notification!.title,
      htmlFormatTitle: true,
    );
    final androidDetails = AndroidNotificationDetails(
      'com.example.chat_app.urgent',
      'mychannelid',
      importance: Importance.max,
      styleInformation: styleInformation,
      priority: Priority.max,
    );
    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
    );

    final notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );
    await flutterLocalNotificationsPlugin.show(0, message.notification!.title,
        message.notification!.body, notificationDetails,
        payload: message.data['body']);
  }

  Future<void> requestPermission() async {
    final messaging = FirebaseMessaging.instance;

    final settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      debugPrint('User granted provisional permission');
    } else {
      debugPrint('User declined or has not accepted permission');
    }
  }

  Future<void> getToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    _saveToken(token!);
  }

  Future<void> _saveToken(String token) async =>
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({'token': token}, SetOptions(merge: true));

  String receiverToken = '';

  Future<void> getReceiverToken(String? receiverId) async {
    final getToken = await FirebaseFirestore.instance
        .collection('Users')
        .doc(receiverId)
        .get();

    receiverToken = await getToken.data()!['token'];
  }

  void firebaseNotification(context) {
    _initLocalNotification();

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      Get.to(
        () => ChatScreen(userId: message.data['senderId']),
        duration: const Duration(milliseconds: 300),
        transition: Transition.rightToLeft,
      );
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      await _showLocalNotification(message);
    });
  }

  Future<String> getAccessToken() async {
    const String firebaseMessagingScope =
        "https://www.googleapis.com/auth/firebase.messaging";
    final client = await clientViaServiceAccount(
        ServiceAccountCredentials.fromJson({
          "type": "service_account",
          "project_id": "decoredashappplatform",
          "private_key_id": "24c595aabfaf88aec14a9e8d676ceba0ec8dff52",
          "private_key":
              "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDb7YWlL89prvKn\ndnoVWJTp4v+wEbC+rRJhp2o1NNhE2oZQqdH11U6L77lX9JyAv5Kl8Vs45OqGrrK8\nud5eEbwwWKRH4+BFSKxr10A+VEJarnMAduF+Y4Ub//V+Wu5u5ZqrAVFUEuHwjcJD\ne7pJJC5KPmOPUofoLsDX+VjNrMNA8CLIjBsruh5l4m01gRTCl4gq/B/KhPgJYHVO\nBSvxvbcUrMrADxbEvyb3tyn+SXHilk4XbOJz2wBeg4pk3/iS6HrH/+AZDm8JcI7N\nwhx7EJVKtLOjG2DwO/N5hnxf1p8IdUzBGQndyEV+LM9VEOJnf6cv9Qeujn1OdH13\n51wLSG1JAgMBAAECggEAA17yH/SKJNAKJxfxShd3/Ne+XIgA4gNMF1QWFCexsuh4\ni472yWJSGGH9wMPejDijekinQcl8cMEHu03MAzwZWtJY/kMXYmh5QBPmB66J79Lh\nr12jGilTVnkHXb7uDaQWSU21XekGLoY1towUcF+OGBQ5uW4l6CCjUwwe2NQvj/S3\nAjZWoRNg2CeJjeRllYYX271Y8ULkjEbECY2mjDJNceh/XeXchA4V3z/EdWCs6QJw\no+yT0UXXmBfH5sY/bq5gU2241edDsIOCK9wiOWGodpHGIvgA5LLHDCUQZhQGNlx/\n9CxxSsu3UZOZL4MDp/qsShQTdzWG/jh9+A/lergmSQKBgQD8NpCQ+m++jlDemx5I\nWXbCdIA2OwURwFNHW+DrFymf8SiArmum8BG5sT9fPsh+sVcrRU2/atEE3Br95Dwp\nVXt2n+awUy0G6zftngw8o9HqzVKGfPgTVjwWAijU7Oms1l/QMQhcpBUlW0fV9TKL\nznEiUM4DoD2RxGlBb3ymbf3//QKBgQDfOtydlVGH2H2gFBc9le/e28R/xM5QxVcB\nxmLr5jZlUzBfYDPVSJwdjGO7rLzlADm+8/Yr3axbmwiZGoh80CSCOzM94qdGyfEY\nnl3NGvA19sK2lJS/eDAY3epzClP1yvEW9aaJ/rL4DL5MC9fslKPsBeykqw11u98Y\nuM89ChSGPQKBgGNnhhb9/ajXIpx5+rd9O0ds71Nwc5EJgkkvtzgxCuDVBaeiFx/W\nosXTTCzX6+GzN64ARKJbEUKfFaxXljacUGryntOEFM0TTBnFHwGPd57Zidsjygql\nBE2QUFOLhJXwcBb4HFmW+hadIXT8jQ15MjHaMzhOobWf+fQmYrSdyWxpAoGADaRG\nOScX3WpgevjfVrcj+oWJo5k+VndI0uXxw6LE7jpAOYPihwUx7ShYK+7peEEkRkQY\nZiPc1ZhK1Thm4OHDaWX+wqhoOo46uptq9g7QYSvcSFYaJP1OSya8nh0idmHZi+Kl\nM8ep3jjBJFqQ7ndC8TiHdqSxZOF/R757g6prCK0CgYBrGuaryiGTEbCx7HYz9/+D\nSpL/cmKMHsB8lclDwGEmrpIIX9Q5Ho/sQIXDnu4f8hetZNxbZtvsltA7V/aDsoWX\nhZy+0VJdexCQUXy+ndBLkCKPmfnzbUj/MRyt2Su+qD/i9B30ADfJXPUZvg26cvO2\njsTkRiXMJ64FcXf+jLrwjg==\n-----END PRIVATE KEY-----\n",
          "client_email":
              "firebase-adminsdk-5wij7@decoredashappplatform.iam.gserviceaccount.com",
          "client_id": "103101517882701367425",
          "auth_uri": "https://accounts.google.com/o/oauth2/auth",
          "token_uri": "https://oauth2.googleapis.com/token",
          "auth_provider_x509_cert_url":
              "https://www.googleapis.com/oauth2/v1/certs",
          "client_x509_cert_url":
              "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-5wij7%40decoredashappplatform.iam.gserviceaccount.com",
          "universe_domain": "googleapis.com"
        }),
        [firebaseMessagingScope]);

    final accessToken = client.credentials.accessToken.data;
    return accessToken;
  }

  Future<void> sendNotification(
      {required String body, required String senderId}) async {
    try {
      final String accessToken = await getAccessToken(); // Get OAuth 2.0 token
      const String url =
          'https://fcm.googleapis.com/v1/projects/decoredashappplatform/messages:send';
      final Map<String, dynamic> notification = {
        "message": {
          "token": receiverToken,
          "notification": {"title": "New Message !", "body": body},
          "data": {
            "click_action": "FLUTTER_NOTIFICATION_CLICK",
            "status": "done",
            "senderId": senderId
          }
        }
      };

      final http.Response response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken', // Use OAuth 2.0 token
        },
        body: jsonEncode(notification),
      );

      if (response.statusCode == 200) {
        LoggerHelper.info('FCM request for device sent!');
      } else {
        LoggerHelper.error('Failed to send FCM request: ${response.body}');
      }
    } catch (e) {
      LoggerHelper.error('Error sending FCM request: $e');
    }
  }
}
