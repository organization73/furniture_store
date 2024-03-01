import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:furniture_store/data/repositories/chat/chats.dart';
import 'package:furniture_store/data/repositories/chat/chats_fake_json.dart';
import 'package:furniture_store/features/chat/screens/chat_detailes.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});
  @override
  Widget build(BuildContext context) {
    List<Chat> chats = parseJson(jsonChats);
    const String imageUrl = 'https://picsum.photos/id/1062/80/80';

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
          title: Text(
        'chat'.tr,
      )),
      body: SafeArea(
        child: ListView.builder(
          itemCount: chats.length,
          itemBuilder: (context, index) {
            Chat chat = chats[index];
            Message lastMessage = chat.messages.isNotEmpty
                ? chat.messages.last
                : Message(
                    id: '',
                    sender: {},
                    timestamp: '',
                    text: '',
                    status: '',
                  );

            return ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 25,
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              title: Text(
                chat.participants.length == 1
                    ? chat.participants[0]['name']
                    : chat.participants[0]['name'] +
                        ', ' +
                        chat.participants[1]['name'],
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              subtitle: Text(
                lastMessage.text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    lastMessage.timestamp,
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey,
                    ),
                  ),
                  if (lastMessage.status == 'uploading')
                    const Icon(
                      Icons.timer_outlined,
                      size: 18.0,
                      color: Colors.grey,
                    ),
                  if (lastMessage.status == 'sent')
                    const Icon(
                      Icons.check,
                      size: 18.0,
                      color: Colors.grey,
                    ),
                  if (lastMessage.status == 'delivered')
                    const Icon(
                      Icons.done_all,
                      size: 18.0,
                      color: Colors.grey,
                    ),
                  if (lastMessage.status == 'read')
                    const Icon(
                      Icons.check,
                      size: 18.0,
                      color: Colors.blue,
                    ),
                ],
              ),
              onTap: () => Get.to(
                () => ChatDetailScreen(
                  chat: chat,
                  profileImage: imageUrl,
                ),
                duration: const Duration(milliseconds: 300),
                transition: Transition.rightToLeft,
              ),
            );
          },
        ),
      ),
    );
  }

  List<Chat> parseJson(Map<String, dynamic> jsonChats) {
    final List<dynamic> chatList = jsonChats['chats'];

    List<Chat> chats = [];
    for (var chatData in chatList) {
      List<Map<String, dynamic>> participants =
          List<Map<String, dynamic>>.from(chatData['participants']);
      List<Message> messageList = List<Message>.from(
        chatData['messages'].map(
          (messageData) => Message(
            id: messageData['id'],
            sender: messageData['sender'],
            timestamp: messageData['timestamp'],
            text: messageData['text'],
            status: messageData['status'],
          ),
        ),
      );

      Chat chat = Chat(
        id: chatData['id'],
        participants: participants,
        messages: messageList,
      );

      chats.add(chat);
    }

    return chats;
  }
}
