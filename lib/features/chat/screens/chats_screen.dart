import 'package:decordash/common/widgets/loaders/animation_loader.dart';
import 'package:decordash/features/chat/screens/search_screen.dart';
import 'package:decordash/features/chat/controllers/chat_controller.dart';
import 'package:decordash/features/chat/widgets/user_item.dart';
import 'package:decordash/features/personalization/controllers/user/user_controller.dart';
import 'package:decordash/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final chatController = Get.put(ChatController());
    final con = Get.put(UserController());
     print(con.user.value.firstName);
    print(con.user.value.firstName);
    print(con.user.value.firstName);
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
              Iconsax.search_normal_copy,
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: chatController.fetchUserChats(),
        builder: (context, snapshot) {
          const emptyWidget = AnimationLoaderWidget(
            text: 'Whoops! Chat List is Empty...',
            animation: 'assets/animations/no_chats.json',
          );
          const loader = Center(child: CircularProgressIndicator());
          final widget = TCloudHelperFunctions.checkMultiRecordState(
              snapshot: snapshot, nothingFound: emptyWidget, loader: loader);
          if (widget != null) return widget;

          final users = snapshot.data!;

          return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) => UserItem(user: users[index]));
        },
      ),
    );
  }
}
