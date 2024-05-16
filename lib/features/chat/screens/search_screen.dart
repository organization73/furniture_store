import 'package:decordash/features/chat/widgets/custom_text_form_field.dart';
import 'package:decordash/features/chat/widgets/user_item.dart';
import 'package:decordash/features/chat/controllers/chat_controller.dart';
import 'package:decordash/utils/constants/sizes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UsersSearchScreen extends StatefulWidget {
  const UsersSearchScreen({super.key});

  @override
  State<UsersSearchScreen> createState() => _UsersSearchScreenState();
}

class _UsersSearchScreenState extends State<UsersSearchScreen> {
  final controller = TextEditingController();
  final chatController = ChatController.instance;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'Users Search',
          ),
        ),
        body: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: TSizes.pagePaddingSpace),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomTextFormField(
                  controller: controller,
                  hintText: 'Search',
                  onChanged: (val) => chatController.searchUser(val),
                ),
                Obx(
                  () => ListView.builder(
                    padding: const EdgeInsets.symmetric(
                        vertical: TSizes.pagePaddingSpace),
                    shrinkWrap: true,
                    itemCount: chatController.search.length,
                    itemBuilder: (context, index) =>
                        chatController.search[index].id !=
                                FirebaseAuth.instance.currentUser?.uid
                            ? UserItem(user: chatController.search[index])
                            : const SizedBox(),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
