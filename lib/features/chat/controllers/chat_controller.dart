import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decordash/data/repositories/chat/chat_repo.dart';
import 'package:decordash/data/repositories/user/user_repo.dart';
import 'package:decordash/data/services/firebase_firestore_service.dart';
import 'package:decordash/data/services/notification_service.dart';
import 'package:decordash/features/chat/model/message.dart';
import 'package:decordash/features/personalization/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController with WidgetsBindingObserver {
  static ChatController get instance => Get.find();
  final chatRepo = Get.put(ChatRepo());
  final userRepo = Get.put(UserRepo());
  final notificationService = NotificationsService();

  ScrollController scrollController = ScrollController();

  Rx<UserModel?> user = Rx<UserModel?>(null);
  RxList<Message> messages = <Message>[].obs;
  RxList<UserModel> search = <UserModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    notificationService.firebaseNotification(Get.context);
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        userRepo.updateSingleField({
          'lastActive': DateTime.now(),
          'isOnline': true,
        });
        break;

      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        userRepo.updateSingleField({'isOnline': false});
        break;
    }
  }

  Future<List<UserModel>> fetchUserChats() async {
    return await ChatRepo.instance
        .fetchUserChatList(FirebaseAuth.instance.currentUser!.uid);
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
      this.messages.value =
          messages.docs.map((doc) => Message.fromJson(doc.data())).toList();
      scrollDown();
    });
  }

  void scrollDown() {
    if (scrollController.hasClients) {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    }
  }

  Future<void> searchUser(String name) async {
    search.value = await FirebaseFirestoreService.searchUser(name);
  }
}
