import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decordashapp/modules/profile/models/user_model.dart';
import 'package:decordashapp/utils/exceptions/exception_handler.dart';
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
    } catch (e) {
      ExceptionHandler.handleAuthException(e);
      rethrow;
    }
  }

  Future<List<UserModel>> fetchUserChatList(String currentUserId) async {
    try {
      final receiversSnapshot = await _db
          .collection('UserChats')
          .doc(currentUserId)
          .collection('receivers')
          .get();

      List<String> receiverIds =
          receiversSnapshot.docs.map((doc) => doc.id).toList();

      final usersSnapshot = await _db
          .collection('Users')
          .where(FieldPath.documentId, whereIn: receiverIds)
          .get();

      return usersSnapshot.docs
          .map((querySnapshot) => UserModel.fromFirebaseDocument(querySnapshot))
          .toList();
    } catch (e) {
      ExceptionHandler.handleAuthException(e);
      rethrow;
    }
  }
}
