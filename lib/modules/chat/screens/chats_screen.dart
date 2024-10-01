import 'package:decordashapp/common/widgets/loaders/animation_loader.dart';
import 'package:decordashapp/data/services/chat/notifications/notification_service.dart';
import 'package:decordashapp/modules/chat/screens/search_screen.dart';
import 'package:decordashapp/modules/chat/controllers/chat_controller.dart';
import 'package:decordashapp/modules/chat/widgets/user_item.dart';
import 'package:decordashapp/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> with WidgetsBindingObserver {
  final notificationService = NotificationsService();
  final chatController = Get.put(ChatController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    notificationService.firebaseNotification(context);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          IconButton(
            onPressed: () => chatController.fetchUserChats(),
            icon: const Icon(
              IconsaxPlusLinear.refresh,
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
