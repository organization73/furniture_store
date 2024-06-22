import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decordash/features/personalization/models/user_model.dart';
import 'package:decordash/utils/exceptions/firebase_exceptions.dart';
import 'package:decordash/utils/exceptions/platform_exceptions.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ChatRepo extends GetxController {
  static ChatRepo get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<UserModel>> fetchAllChats(String currentUserId) async {
    try {
      final snapshot = await _db
          .collection('Users')
          .where('id', isNotEqualTo: currentUserId)
          .get();

      return snapshot.docs
          .map((querySnapshot) => UserModel.fromFirebaseDocument(querySnapshot))
          .toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }
}
