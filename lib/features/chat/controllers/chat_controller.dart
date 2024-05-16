import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decordash/data/services/firebase_firestore_service.dart';
import 'package:decordash/features/chat/model/message.dart';
import 'package:decordash/features/personalization/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  static ChatController get instance => Get.find();

  ScrollController scrollController = ScrollController();

  RxList<UserModel> users = <UserModel>[].obs;
  Rx<UserModel?> user = Rx<UserModel?>(null);
  RxList<Message> messages = <Message>[].obs;
  RxList<UserModel> search = <UserModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getAllUsers();
  }

  void getAllUsers() {
    FirebaseFirestore.instance
        .collection('Users')
        .orderBy('lastActive', descending: true)
        .snapshots(includeMetadataChanges: true)
        .listen((users) {
      this.users.value =
          users.docs.map((doc) => UserModel.fromJson(doc.data())).toList();
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
