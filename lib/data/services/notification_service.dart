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
          "project_id": "decoredashplatform",
          "private_key_id": "50e1841bfbf4f91cc46a0af9eb57c772d13f7155",
          "private_key":
              "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDiSGDbooWCq3Ba\nfXL2KmNlDP5AWv/e90R3b7y6h4hoW46NTwCM57Mleir33agvAEkPhvGmZvGsk7Vo\nZsUoLvzdGJSCEjLXUgtEAMdOuV7MWB0W3W56zhnmn6XxYoxRFuuI6s8oE3h0BbFX\neACqNP4p2kB0/mebJW5/L/3eDUzGK5l0dTqwXij2LKM7IuRlQ8IRyZgWDBL6cXWz\nbDe153wSw0pq2q7bgGMOX8YBOwb8aZLqiUP2UYI9cUdq8ZMVuSI6ezL9WTX7MkUy\nQV+1iTQoPDHZRbyMHbW1o6Cc22kny7rxMEcBgrybDyrIETWuHY4n2/IR99VF6YNm\nbjFFP7gZAgMBAAECggEAElCqakySwttOejyKKAuRRPYSxDG5YRohdAtaurxKmavD\nc4OP91evo9pqDOrneHps73FMMNxHNmE0PzGGRrTa6ahaKNcBP3VYDRaFC0Wsuxxs\nqlOc5Bq3dPe6DjocQln5EXlz7/n3d2iYjIxdfWlRoyCTtAR9bUzPz0KaqTTpYGaz\nA7CiQmPVq627YLHH1P/imHu3pJkrm/l+U/aDtM344UiP5xucsuSZTItaeChCMuf4\noidNcpAAq9MhPKBNFox9UDZkA1VYi0oPW2ckiqCjI9HgFUownWaGt/H9RDKZpWZE\nPujOGbz9y+0Wps067V1knl6NDu9rWNU3rdFTnzbIwQKBgQD63GwyxU0POZuXaecT\n+al8S0eF2Dp9udF8qSAvSqo2tqeQyRHy5Gymio8jjMq4qmGCQfc+cS37DDseWiXs\nd1vqtHo/+ti9VCC83GbDS9JheSo3ozLObc1Cs7Wy5qSZ3ZAB5FHTgQj68B15vlZx\nd6VC+C0wLrW0AOpwTQYfKyJtKQKBgQDm6w+e+UZtCMZ34IZT5MZ5lwEWf1FYAJoS\nBHDfNntG/QNR+8QP8Fq+OKQpV/QpZJRhuxTgSxVT/ui/N5JCH1yeysQCTDP70bni\nOR1VmeTgB7Nd1oEQ7y5AKoG90/MCvHJragKS8RaHyGOJCPaM+TxINJ8HHmEHBwzm\nmdpId0lhcQKBgQDVdrFfNoLPHM8oNcabOcwd5xTycL+88lyvPl8Tvu4+ZokJ6/8o\n93T49li9AHYUU29r3uQbr0VYJd08g6tXn22It5B7VuINoUPGUankL2XS6b6h325B\nOC/8vV004YxZHa8H3Rg/6MISfjYmvW9jWFM5PGN/Z4/Ynxre+rvl09eUmQKBgAcg\nxGes3C6rcazrolnemv3P2nm+Tl2AD0F1H6LURLPpRXv3YJL5YWOzzeV00JWihC4M\nH1XZG3xvRvH4HiyqWSqRqcFEZupkC+/ewXgN+xGrSy8fWvaR24Shi0W30C2KcaG9\nMP0mMgLY/bGSNEIfw2ubLDmFB4u2/P/1Sdaoz/wRAoGBAM0RHF6AIYQlJfiuDZkP\neJbupWDZ7/v04vnyVYOKVsjBOnwx2zwF4qEpOi/yPnvDb4tUiOaUc47Xjh9o4EnW\nGae+mTNecoxsaj/JPA7iVUs/EAebXn+U6ZZFstmx3v61HaPtQLuBgeVCsr71xb4r\nVuLgHltL6BOAm94I0N7xShyS\n-----END PRIVATE KEY-----\n",
          "client_email":
              "firebase-adminsdk-cb3be@decoredashplatform.iam.gserviceaccount.com",
          "client_id": "115368558199234501613",
          "auth_uri": "https://accounts.google.com/o/oauth2/auth",
          "token_uri": "https://oauth2.googleapis.com/token",
          "auth_provider_x509_cert_url":
              "https://www.googleapis.com/oauth2/v1/certs",
          "client_x509_cert_url":
              "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-cb3be%40decoredashplatform.iam.gserviceaccount.com",
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
          'https://fcm.googleapis.com/v1/projects/decoredashplatform/messages:send';
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
