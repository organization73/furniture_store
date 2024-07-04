import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decordash/data/repositories/authentication/api_services.dart';
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

  Future<List<UserModel>> fetchUserChatList(String currentUserId) async {
    try {
      
      print(currentUserId);
      final receiversSnapshot = await _db
          .collection('UserChats')
          .doc(currentUserId)
          .collection('receivers')
          .get();
      List<String> receiverIds =
          receiversSnapshot.docs.map((doc) => doc.id).toList();

      print("receiverIds $receiverIds");
      final usersSnapshot =
          await _db.collection('Users').where('id', whereIn: receiverIds).get();

      final lastImagesSnapshot = await _db
          .collection('Users')
          .doc(currentUserId)
          .collection('chat')
          .doc(receiverIds[0])
          .get();
      for (var element in usersSnapshot.docs) {
        print("element ${element.data()}");
      }
      List<UserModel> us = [];
      for (var e in receiverIds) {
        print("sss");
        var r = await HttpService.instance.getUserById(e);
        print(r);
        us.add(UserModel(
          id: r['_id'],
          email: r['email'],
          imageUrl: r['imageUrl'] ??
              "https://t4.ftcdn.net/jpg/00/65/77/27/360_F_65772719_A1UV5kLi5nCEWI0BNLLiFaBPEkUbv5Fv.jpg",
          firstName: r['firstName'],
          lastName: r['lastName'],
          username: r['username'],
          isConfirmed: r['isConfirmed'],
          type: r['type'],
        ));
        print(us);
      }
      // print(us);
      return us;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }
}
