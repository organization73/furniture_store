import 'package:decordash/common/widgets/loaders/animation_loader.dart';
import 'package:decordash/data/repositories/user/user_repo.dart';
import 'package:decordash/data/services/notification_service.dart';
import 'package:decordash/features/chat/screens/search_screen.dart';
import 'package:decordash/features/chat/controllers/chat_controller.dart';
import 'package:decordash/features/chat/widgets/user_item.dart';
import 'package:decordash/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

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
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        UserRepo.instance.updateSingleField({
          'lastActive': DateTime.now(),
          'isOnline': true,
        });
        break;

      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.hidden:
      case AppLifecycleState.detached:
        UserRepo.instance.updateSingleField({'isOnline': false});
        break;
    }
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
              Iconsax.search_normal_copy,
            ),
          ),
          IconButton(
            onPressed: () => chatController.fetchUserChats(),
            icon: const Icon(
              Iconsax.refresh_copy,
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
