import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furniture_store/data/repositories/chat/chats.dart';
import 'package:furniture_store/data/repositories/chat/chats_fake_json.dart';
import 'package:furniture_store/features/personalization/controllers/chat_controller.dart';
import 'package:furniture_store/features/personalization/models/user_model.dart';
import 'package:furniture_store/utils/constants/enums.dart';

class ChatDetailScreen extends StatefulWidget {
  // final Chat chat;
  // final String profileImage;
  final UserModel? user1 = UserModel(
      accountType: AccountType.regular,
      authorities: [],
      avatar: "",
      firstName: "Nader",
      lastName: "Sakr",
      confirmCode: "",
      createdDate: "",
      email: "nadersakr",
      id: "2",
      kcyAddress: "aaa",
      verified: false,
      state: AccountState.active,
      password: "",
      roles: Roles.user,
      phoneNumber: "01288235749",
      userName: "nader");

  ChatDetailScreen({
    super.key,
    //  required this.chat,
    //  required this.profileImage,
  });
  void initState() {
    ChatController.instance.socketService.joinRoom('1');
  }

  @override
  ChatDetailScreenState createState() => ChatDetailScreenState();
}

class ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Row(
          children: [
            // CircleAvatar(
            //   backgroundImage: NetworkImage(widget.profileImage),
            //   radius: 20.0,
            // ),
            SizedBox(width: 15.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(
                //   'Chat ${widget.chat.id}',
                //   style: Theme.of(context).textTheme.bodyLarge,
                // ),
                // Text(
                //   widget.chat.participants
                //       .map((participant) => participant['name'])
                //       .join(', '),
                //   style: Theme.of(context).textTheme.bodyMedium,
                // ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Card(
              elevation: 0,
              color: Theme.of(context).scaffoldBackgroundColor,
              child: ListView.builder(
                reverse: true,
                itemCount: 1,
                // itemCount: widget.chat.messages.length,
                itemBuilder: (context, index) {
                  // Message message =
                  //     widget.chat.messages.reversed.toList()[index];

                  // Check if the current message is the first one of the day or if it has a different date than the previous message
                  // bool showDateSeparator = index ==
                  //         widget.chat.messages.length - 1 ||
                  //     message.timestamp.substring(0, 10) !=
                  //         widget.chat.messages.reversed
                  //             .toList()[index + 1 < widget.chat.messages.length
                  //                 ? index + 1
                  //                 : index]
                  //             .timestamp
                  //             .substring(0, 10);

                  return Column(
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            ChatController.instance.socketService
                                .setupUser("100");
                          },
                          child: const Text("set user")),
                      ElevatedButton(
                          onPressed: () {
                            ChatController.instance.socketService
                                .joinRoom('800');
                          },
                          child: const Text("join room")),
                      ElevatedButton(
                          onPressed: () {
                            ChatController.instance.socketService
                                .leaveRoom('800');
                          },
                          child: const Text("leave room")),
                      ElevatedButton(
                          onPressed: () {
                            ChatController.instance.socketService
                                .sendMessageToRoom("800", "heeeeeeeey");
                          },
                          child: const Text("send message to")),

                      // Display the date separator above the first message of the day
                      // if (showDateSeparator)
                      //   Container(
                      //     padding: const EdgeInsets.symmetric(vertical: 8.0),
                      //     child: Text(
                      //       message.timestamp
                      //           .substring(0, 10), // Extract date part
                      //       style: const TextStyle(
                      //         color: Colors.grey,
                      //         fontWeight: FontWeight.bold,
                      //       ),
                      //     ),
                      //   ),

                      // Display the message
                      Align(
                        // alignment: message.sender['id'] ==
                        //         widget.chat.participants[0]['id']
                        //     ? Alignment.centerRight
                        //     : Alignment.centerLeft,
                        child: SizedBox(
                          width: 300,
                          child: ListTile(
                            title: Container(
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: Colors.amber,
                                // color: message.sender['id'] ==
                                //         widget.chat.participants[0]['id']
                                //     ? Colors.grey.shade300
                                //     : Colors.blue.shade100,
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              child: const Text("hello"),
                              // Text(
                              //   message.text,
                              //   style: const TextStyle(
                              //     color: Colors.black,
                              //   ),
                              // ),
                            ),
                            subtitle: const Align(
                              // alignment: message.sender['id'] ==
                              //         widget.chat.participants[0]['id']
                              //     ? Alignment.bottomRight
                              //     : Alignment.bottomLeft,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Text("hello"),
                                //  Text(
                                //   message.timestamp.substring(11),
                                // ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Type a message...',
                    ),
                  ),
                ),
                SizedBox(width: 8.0.w),
                FilledButton(
                  onPressed: () => _sendMessage(ChatController.instance),
                  child: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage(ChatController chatController) {
    String messageText = _messageController.text;
    // DateTime currentDateTime = DateTime.now();

    if (messageText.isNotEmpty) {
      // chatController.socketService.sendMessageToRoom('1', messageText);
      chatController.socketService.recieveMessage();

      // Create a new message

      // // Create a new message
      // Message newMessage = Message(
      //   id: 'm${widget.chat.messages.length + 1}',
      //   sender: {"id": "userA123", "name": "UserA"},
      //   timestamp:
      //       '${currentDateTime.year}-${(currentDateTime.month)}-${(currentDateTime.day)}/'
      //       '${(currentDateTime.hour % 12)}:${(currentDateTime.minute)} '
      //       '${currentDateTime.hour < 12 ? 'AM' : 'PM'}',
      //   text: messageText,
      //   status: "sent",
      // );
      // // Add the new message to the chat messages list
      // setState(() {
      //   widget.chat.messages.add(newMessage);
      // });

      // // Update the JSON data
      // updateJsonData();

      // Clear the input field
      _messageController.clear();
    }
  }

  // void updateJsonData() {
  //   // Create a copy of the original JSON data
  //   Map<String, dynamic> updatedJsonChats = Map.from(jsonChats);

  //   // Find the chat in the JSON data
  //   for (var chatData in updatedJsonChats['chats']) {
  //     if (chatData['id'] == widget.chat.id) {
  //       // Add the new message to the chat's messages list in the JSON data
  //       chatData['messages'].add({
  //         "id": widget.chat.messages.last.id,
  //         "sender": {
  //           "id": widget.chat.messages.last.sender['id'],
  //           "name": widget.chat.messages.last.sender['name'],
  //         },
  //         "timestamp": widget.chat.messages.last.timestamp,
  //         "text": widget.chat.messages.last.text,
  //         "status": widget.chat.messages.last.status,
  //       });

  //       break; // Stop searching once the chat is found
  //     }
  //   }

  //   // Update the JSON data in the widget
  //   setState(() {
  //     jsonChats = updatedJsonChats;
  //   });
  // }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}
