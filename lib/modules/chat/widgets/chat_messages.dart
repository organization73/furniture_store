import 'package:decordashapp/modules/chat/model/message.dart';
import 'package:decordashapp/modules/chat/controllers/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'empty_widget.dart';
import 'message_bubble.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key, required this.receiverId});
  final String receiverId;

  @override
  Widget build(BuildContext context) {
    final chatController = ChatController.instance;

    return Obx(
      () => chatController.messages.isEmpty
          ? const Expanded(
              child: EmptyWidget(icon: Icons.waving_hand, text: 'Say Hello!'),
            )
          : Expanded(
              child: ListView.builder(
                controller: chatController.scrollController,
                itemCount: chatController.messages.length,
                itemBuilder: (context, index) {
                  final isTextMessage =
                      chatController.messages[index].messageType ==
                          MessageType.text;
                  final isMe =
                      receiverId != chatController.messages[index].senderId;

                  return isTextMessage
                      ? MessageBubble(
                          isMe: isMe,
                          message: chatController.messages[index],
                          isImage: false,
                        )
                      : MessageBubble(
                          isMe: isMe,
                          message: chatController.messages[index],
                          isImage: true,
                        );
                },
              ),
            ),
    );
  }
}
