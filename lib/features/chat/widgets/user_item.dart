import 'package:decordash/features/chat/screens/chat_screen.dart';
import 'package:decordash/features/personalization/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class UserItem extends StatefulWidget {
  const UserItem({super.key, required this.user});

  final UserModel user;

  @override
  State<UserItem> createState() => _UserItemState();
}

class _UserItemState extends State<UserItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => ChatScreen(userId: widget.user.id))),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(widget.user.avatar),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: CircleAvatar(
                  backgroundColor:
                      widget.user.isOnline ? Colors.green : Colors.grey,
                  radius: 5,
                ),
              ),
            ],
          ),
          title: Text(
            widget.user.userName,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            'Last Active : ${timeago.format(widget.user.lastActive ?? DateTime.now())}',
            maxLines: 2,
            style: const TextStyle(
              color: Colors.amber,
              fontSize: 15,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      );
}
