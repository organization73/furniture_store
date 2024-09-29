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
          "private_key_id": "7c5ec2148d990cb4843883312a49c41d248e9e1d",
          "private_key":
              "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQC0lhLU8DsoaSD0\nTEhGDlJOXtx4iak4b1cQTjub0fkEHmwLTcaPeHINZriq9/tb+nZHMp+TqQh78mn9\nGZokgu5pSdHzW6BEnwjwvqZxMGE2q34Q8Oo6A6S2Hg58PYY+HSZ3kT39B2MNmc5q\nRMtZXnJXRvuGa6It23xt4AFMzPIZHgcs0VuUFQ0BO2F3XACio7R3ZuE07JnjgY6V\niTRin0j+Y1c5LzNAvHpQx0JMH1vnVWeGrxiVtcBSYKVzmO3/Hu3qNT19T/VKK70D\n0aCo5ofTp+E6KTG1flS7p7vJjKcI4fiZuj9VS5VK0PXl3KYNUz4XUVsLk9x44VPo\nfQBSVuvvAgMBAAECggEAKKvEAgE40ZkbuumTPXPsRYpHzT3zxqoMybdU5Xscwji3\nzLPvjFBsH2iLHrZK/iQij1ZvaiofpwqppD8n4CE84Kmnh0+TgODweof1pHho7I8j\nDV204uv/JKUQThrtKQAXscYcV+hZ/q4tNvHXeoEy70UlUNjc5ccQ9w4EPO/LdqxT\nx6WfMrq+biKy2BvN4C6mSWFk4DWm9yQX4cwEyzuPK0WVcRQKrlfaQWHpjJnWIdvt\nQvxqzDTgdU4nzwnIGvx2XP/Bw5/JuOSe7j/o+vUSfQ3AAf9f4UZz+vXWe3wOR07m\nK+7Y6YatzBrmzY3O8J+SbWI2mMFkmWhXmmLGtb85gQKBgQDXzGj1HbKtykrs/aG9\nPqJJ0KesJ/UMXPcWsn7Epmho77eXym+PPKeA62TcV2zr1NgVmdVuG/cesHwqDvMh\n6c4C5SQIK9JiVyxKiEl12zeotWHA6UK1eJQz0r8fyct/ALg9A78rb4vRdPmS86x8\nlZ3KmYcaxxmDCFjturcC8qsuqQKBgQDWOl11cRP0xoeKWY9sZHtoSsJKQIoXOXrO\nXeia5ocr+caDyrdjl89yyKjVihNhBdPHVFTHU1DL6hF899ZgMG66A7ZYpEyj3YUR\n3ENb31arMAe8+RSE1FLL1FdyxC9vSvPNKI5Zi5EETq71djONiTewCmfOTKogXQWJ\ng3tSSB5c1wKBgQDNUiSuy0HdTvL5B90ipPxeRROznhTuXWmPA+fPjREcfrBs0ORS\nIYCyDcXaS6hLviiWbNaAPEVkwsBwd+bm5oDnikM9LwyuGoj+pStX4mrTrzhCBu48\noWxI3oSQZzyiKvogu3bhifE7KhPnuMbthqEqSecdGEByxrduAU/tkxxCeQKBgFT6\nsAofQghOHIQgBMm9jkqPpUSpF14hGfr0u4l+us4R9dJfvqGOHedte7PBYvCQzDJ8\n3Gh5P0q0Xh2RfoOHktTNFi9RdWlnPRsZocq27H1ZvygSMjaCtxlN8SaAdkSSmeWf\nGeChgXQQ9kw+iDKz5Ng7OHRYawANhl3HP0sjeo/fAoGBAJDO/vY1a9MtZHCnedG5\nBW2SU80cVw0eH1vLB40pdbovn7F5KJrvbo+JtHfiU9Qmvp/wBhI5yTh1hpCwgYXK\nllrmYBNQJjr1pn2sDhaS8LnW/wOvNVirDs1exhWt8RQp+Hk6Q8lfuUrM0pv4nbdE\nAHr8q1vp2yESJP7amFJ7zLD9\n-----END PRIVATE KEY-----\n",
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
