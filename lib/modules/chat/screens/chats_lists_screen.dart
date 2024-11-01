import 'package:decordashapp/common/widgets/loaders/animation_loader.dart';
import 'package:decordashapp/modules/chat/screens/users_search_screen.dart';
import 'package:decordashapp/modules/chat/controllers/chat_controller.dart';
import 'package:decordashapp/modules/chat/widgets/user_item.dart';
import 'package:decordashapp/modules/errors/screens/no_connection_screen.dart';
import 'package:decordashapp/modules/profile/models/user_model.dart';
import 'package:decordashapp/utils/helpers/cloud_helper_functions.dart';
import 'package:decordashapp/utils/helpers/network_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class ChatsListScreen extends StatelessWidget {
  const ChatsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (!NetworkManager.instance.isOnline) {
        return const ErrorScreen();
      } else {
        final chatController = Get.put(ChatController());

        return Scaffold(
          appBar: AppBar(
            title: Text('chats'.tr),
            actions: [
              IconButton(
                onPressed: () => Get.to(
                  () => const UsersSearchScreen(),
                  duration: const Duration(milliseconds: 300),
                  transition: Transition.rightToLeft,
                ),
                icon: const Icon(
                  IconsaxPlusLinear.search_normal,
                ),
              ),
            ],
          ),
          body: StreamBuilder<List<UserModel>>(
            stream: chatController.fetchUserChats(),
            builder: (context, snapshot) {
              const emptyWidget = AnimationLoaderWidget(
                text: 'Whoops! Chat List is Empty...',
                animation: 'assets/animations/no_chats.json',
              );
              const loader = Center(child: CircularProgressIndicator());
              final widget = TCloudHelperFunctions.checkMultiRecordState(
                  snapshot: snapshot,
                  nothingFound: emptyWidget,
                  loader: loader);
              if (widget != null) return widget;
              final users = snapshot.data!;
              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return UserItem(user: users[index]);
                },
              );
            },
          ),
        );
      }
    });
  }
}
