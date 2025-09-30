import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decordash/features/notifications/model/notifications_model.dart';
import 'package:decordash/utils/exceptions/firebase_exceptions.dart';
import 'package:decordash/utils/exceptions/platform_exceptions.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class NotificationsRepo extends GetxController {
  static NotificationsRepo get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<Notifications>> getNotifications() async {
    try {
      final snapshot = await _db
          .collection('Notifications')
          .orderBy('timestamp', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => Notifications.fromFirebaseDocument(doc))
          .toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }
}