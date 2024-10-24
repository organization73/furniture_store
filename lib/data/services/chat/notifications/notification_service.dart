import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decordashapp/modules/chat/screens/chat_screen.dart';
import 'package:decordashapp/utils/logging/logger.dart';
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
          "project_id": "decordashapp-2cc20",
          "private_key_id": "de8613746d961e48f302dad4c4f8be662bbded96",
          "private_key":
              "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQC0k704iGzUpxM4\nfXsjqo0NFc8dteCLsJsTpqn3sF4svZX/ka1c2wOWoavZA9/sS1ms6h19SRqZ3XRG\nKCnTegjsDVTelg3cc8bj+NbXsySkY3bQ2SPxbHlV7PQwhF7yWKQSPIH4cZv7Wtqx\nsUHIwKu6QpzSkuBHTJFuYy64xfshcMV3sbC7wG5cUX8/h0Dlu/G+H3UiHDN/NJvk\nm1En3wC950nyGLSzO1rZBGfsI0AX1uE903446W9NIiTKb2wQCtNWF0aNvd2XvJdc\n3EK3lURYl/xvEPK/QDJThf3wtvUjEccgHESS12Sjq4TGoX1g16/B9fyYhrAm0mAe\nsNNb2fcfAgMBAAECggEAD1jnIiDmLwSsK4buqk9agZwy6DGHDhhKddcaZwTEXEUY\ntInrFBNBMNI4ys77fxfAXWPgcb9+1UjvEu9i7qhWjclsRya1suDcLI//ooGFQbt6\nY7GwzloLzfO/pUf60doax7oAyd7OBQTpxWRtVOSbM89piLQW/7hQO/OOCwI4n9TT\nA/oFxdalq5WbepcfoYCABjMJJedyWENuldir6vaGcuJOYc2DjY+BVpLucUay9jrx\nlNnw4D4uWuH7JGMrGyaqgm3kWTlMyKxNOONXN+YiESlb8XYq5tuXwnq9JMFe85et\nvqALddWteBtvbk77aeAJpOGXMWO4Fck+8KGO0u308QKBgQDyb6WbqZsp0n6EQSSH\nsoZ0T26i7XGhht1d8nRXRGB8h2INkrgxoLHpxfaeO2TIy0S/ucWYwTk9GeDse8dh\n8mTvaiqIxuhNIHYzy+53xAlq+uKWTv6YWsK/4xxR799RbQCNG+6aQT1Xz/0YeUhu\ngv1zR+0cZOOvWAGGHBqH6qmV7QKBgQC+rhnKQOoAUoVZqcpmcT/mGSfMAPq2wHaM\nS7errkBnpxbHz80Zrnpq0fYeEHklieLwKebXq8JG7Ot03cNdA42L/qiAC+IQsmwU\n07rFkB4Y0u8qnVrcsHxoUxErVk4jnvdV2rtPyDgvrMHW8TlbrFUQlpC7S9ypaerU\n9cmFDeDfuwKBgQCpVfKG1+DZRX25QwcRAVGIzDKq+s7z1A+rHz7D9a6vTKDgeirN\n/0BF2VB5FWNAHTrX8BpkqBIi64B/rbWGZJi74Zv0DXsU5Cer5jWa0gMCBlteQa7z\nG/ILtcaCNNn3Nfu8lFYEyKzgORa/kXdWOYhujT7BJncicoYd9mNRrEbnwQKBgANo\nMvfFLykwUEeo2//2mBCxdF+VyOUJDVU2aSK9K1Nuzd5mHSEPWAqek8o3uyJrk019\nQi2qWP9RbmeZKst3q8jLlREspS5tMbcxjU3IZHFHG5TkWOJGmQJ4MX9XvG+wgHTd\nQqmLR026xX/ksYSs0JxKRG3ETj4MsXB6r84b0F/PAoGBAInRD+JOJl3i+mFMr+ko\n1zsl/zA3tjoxVeuEWGwOkd3yLm2DKjnoipyyMyfsqJ88KjNq8OZ3GK6+dryH5ixj\n4slhYJ9TJs6uptHLolv0Ewkt6IYTOHh415F1HU3kpGP1oDgzncCTaV+yiTOpnbdN\n6rra5mZs7dYvqzDdUgZ7+PT+\n-----END PRIVATE KEY-----\n",
          "client_email":
              "firebase-adminsdk-5ok8k@decordashapp-2cc20.iam.gserviceaccount.com",
          "client_id": "101089103956871665332",
          "auth_uri": "https://accounts.google.com/o/oauth2/auth",
          "token_uri": "https://oauth2.googleapis.com/token",
          "auth_provider_x509_cert_url":
              "https://www.googleapis.com/oauth2/v1/certs",
          "client_x509_cert_url":
              "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-5ok8k%40decordashapp-2cc20.iam.gserviceaccount.com",
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
          'https://fcm.googleapis.com/v1/projects/decordashapp-2cc20/messages:send';
      final Map<String, dynamic> notification = {
        "message": {
          "token": receiverToken,
          "notification": {"title": "New ChatMessageModel !", "body": body},
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
