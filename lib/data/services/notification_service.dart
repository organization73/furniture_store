import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decordash/utils/logging/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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
      // Get.to(
      //   () => ChatScreen(userId: message.data['senderId']),
      //   duration: const Duration(milliseconds: 300),
      //   transition: Transition.rightToLeft,
      // );
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
          "project_id": "decordashstore-98472",
          "private_key_id": "0528b95750b2aa332e6cbda0d729518f241eeb1a",
          "private_key":
              "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDB0JKEUKBO0+eo\n6gVK6fxRqzQhIJM9yl5zypatS454ObX+FRokQm7fECKFINIs2AuWcXOnFSMQlQn3\nZUuRNcVKvvIUMTx1t9cfhiD/a9AnSqM6sVmx1TPaKP0n6YCdTNm9xOC6NTHgNSq6\n4ghDKCtXiOwVobU5thnGY8ZWBis4QaRzV7fmxfJLFFnGVf3LizeWqp0UfV62KnnN\niiRYoeTjA3EXAuH1Peu6UMvyen5q+XlnokRna6dsacmWmu+07A6FU0H0bARVqOUl\nU6P/voHErV3IueFypTGIKmcycqFLWkcJpv4AicEDZeI/xIcp9M+OUXEQnN+b2rM4\nXuLw0WUhAgMBAAECggEABXrBibFDkm3RkN785+PfWOoIyB7770eS1uc58sKZho5Y\n2pQf3fBImZneUkOCba4jtbqVsHot71LwhXrqzykJuzFCP2mc8fp+m11E2iGHnnTD\nLcnormtH0ydxgx1cVvGVkKcS3bn/SGsvPvDKKUvm3cuLNb3s8OB41O/qWQOzD/hX\nrF8zmgdOPzcPZo4tP4B8Kad76qKZYI51A6YWN8y/we51wIzmOJkB44jAr+8ZqCLy\ndRmDrtFIYhU5HT6q1MhykslLdVaR5bqN/mL/xpTXoceUmnJ6iW2dBP9sM1+j9DEm\nBJrs/FFmw51PV6aApBtm9hvNxVbNyPocJZeW3EYfeQKBgQDlhKLPird0gwTgG3rk\nKQ2DE9XKVsCaKrtj0p/111yRVevAETVU2hmiL+Ev9dWAJyVOI0DgxCWgie01lRUY\nW5jKg+U9sydUoo5B/cfO+SSuFDhKNMJ0aVVkDYrRi/gA1SJt2CvDvQsPQJegCOhA\neSsYEeZ+gmuUjv38UfYHMzHD8wKBgQDYLVooGc82kwWZqAhTtVua30DZPPmtVMhw\ncZ+/tlm3r5qOxquTDrHwF8nwSoUdKVYKfu1DEF6Soy65e5KKuTuC4Lj8lpJIY9BX\nyKC7WHeSbdAN9/eG3cnrCnOFoa9XQeseOxn5+7bMOiuGpqM7odIYi6DtbHC7tGle\neeNJ+c57mwKBgQDdpFB1i8fNxBiZMvBiFSLvSeBTHaOxPULpCyVeCzNhRk/7kqKl\n5liKvyH/Zq9eqm7kHjcw1zpe5dMkw2szsoDCUMy34KJCoRgvshuaTA6X7P7O6lQ+\nhtnnXQyJf1lntGsjGHZq98wOVpoV+YQPfvOWsvKbiObK96teVuf33ABa8QKBgH2C\nh0+0/GuxHJVDy+Hd79uRNzNphYSvLtip/5ftJVXSbKfsjP0KkSDWjvYmLfbqYvwh\nCVvgiygT+jLSnhhQx06LbpuoSDIjUXlGEJv1Fyc6/oq9p0b0SiFepge2AfllWj7p\nDYHoNQ+Jzm+VHDypDTQXDU4LocA5VNv3ZJE0qj91AoGAHiXLrhbcJNLCaK1FqFAg\nHignBDFjLZQ6u4xn5bmN/kqPnRnaLg8zCW4MfOP17brHiT49V/MKst/jr6+TsDlN\nNh3HPlPBtUVl9kqz9o1nnHodeQWnqtNzTSZU1tv09yywrZXfa/zNY7YW8nrVl62Y\nnMUAK6I64EW3xbMfUh23Zf0=\n-----END PRIVATE KEY-----\n",
          "client_email":
              "firebase-adminsdk-7r7n6@decordashstore-98472.iam.gserviceaccount.com",
          "client_id": "100995457849110706700",
          "auth_uri": "https://accounts.google.com/o/oauth2/auth",
          "token_uri": "https://oauth2.googleapis.com/token",
          "auth_provider_x509_cert_url":
              "https://www.googleapis.com/oauth2/v1/certs",
          "client_x509_cert_url":
              "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-7r7n6%40decordashstore-98472.iam.gserviceaccount.com",
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
          'https://fcm.googleapis.com/v1/projects/decordashstore-98472/messages:send';
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
