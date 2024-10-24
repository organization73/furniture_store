import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decordashapp/data/repositories/chat/chat_repo.dart';
import 'package:decordashapp/data/repositories/user/user_repo.dart';
import 'package:decordashapp/data/services/chat/notifications/notification_service.dart';
import 'package:decordashapp/modules/chat/model/chat_message_model.dart';
import 'package:decordashapp/modules/profile/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController with WidgetsBindingObserver {
  static ChatController get instance => Get.find();

  final chatRepo = Get.put(ChatRepo());
  final userRepo = UserRepo.instance;
  final notificationService = NotificationsService();

  ScrollController scrollController = ScrollController();

  Rx<UserModel?> user = Rx<UserModel?>(null);
  RxList<ChatMessageModel> messages = <ChatMessageModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    notificationService.firebaseNotification(Get.context);
  }

  Stream<List<UserModel>> fetchUserChats() {
    return FirebaseFirestore.instance
        .collection('UserChats')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('receivers')
        .snapshots()
        .asyncMap((snapshot) async {
      List<String> receiverIds = snapshot.docs.map((doc) => doc.id).toList();
      List<UserModel> users = [];
      for (String receiverId in receiverIds) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('Users')
            .doc(receiverId)
            .get();
        users.add(UserModel.fromFirebaseDocument(userDoc));
      }
      return users;
    });
  }

  void getUserById(String userId) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .snapshots(includeMetadataChanges: true)
        .listen((user) {
      this.user.value = UserModel.fromJson(user.data()!);
    });
  }

  void getMessages(String receiverId) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('chat')
        .doc(receiverId)
        .collection('messages')
        .orderBy('sentTime', descending: false)
        .snapshots(includeMetadataChanges: true)
        .listen((messages) {
      this.messages.value = messages.docs
          .map((doc) => ChatMessageModel.fromJson(doc.data()))
          .toList();
      scrollDown();
    });
  }

  void scrollDown() {
    if (scrollController.hasClients) {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    }
  }
}
