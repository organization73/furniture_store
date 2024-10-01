import 'package:decordashapp/data/services/chat/firebase_chat_service.dart';
import 'package:decordashapp/modules/personalization/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchUsersController extends GetxController {
  static SearchUsersController get to => Get.find();

  final TextEditingController searchNaemController = TextEditingController();
  RxList<UserModel> search = <UserModel>[].obs;

  Future<void> searchUser(String name) async {
    search.value = await FirebaseFirestoreService.searchUser(name);
  }
}
