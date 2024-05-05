import 'package:decordash/common/widgets/images/circular_image.dart';
import 'package:decordash/features/chat/widgets/chat_messages.dart';
import 'package:decordash/features/chat/widgets/chat_text_field.dart';
import 'package:decordash/provider/firebase_provider.dart';
import 'package:decordash/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.userId});

  final String userId;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final chatController = FirebaseProvider.instance;

  @override
  void initState() {
    chatController
      ..getUserById(widget.userId)
      ..getMessages(widget.userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.pagePaddingSpace),
        child: Column(
          children: [
            ChatMessages(receiverId: widget.userId),
            SizedBox(
              height: TSizes.spaceBtwSections/2,
            ),
            ChatTextField(receiverId: widget.userId)
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() => AppBar(
          title: Obx(
        () => chatController.user.value != null
            ? Row(
                children: [
                  CircularImage(
                    imageUrl: chatController.user.value!.avatar,
                    isNetworkImage: true,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        chatController.user.value!.userName,
                      ),
                      Text(
                        chatController.user.value!.isOnline
                            ? 'Online'
                            : 'Offline',
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                              color: chatController.user.value!.isOnline
                                  ? Colors.green
                                  : Colors.grey,
                            ),
                      ),
                    ],
                  ),
                ],
              )
            : const SizedBox(),
      ));
}
