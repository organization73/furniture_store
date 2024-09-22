import 'package:decordashapp/common/widgets/images/circular_image.dart';
import 'package:decordashapp/features/chat/screens/chat_screen.dart';
import 'package:decordashapp/features/personalization/models/user_model.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

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
        onTap: () => Get.to(
          () => ChatScreen(userId: widget.user.id),
          duration: const Duration(milliseconds: 300),
          transition: Transition.downToUp,
        ),
        child: ListTile(
          leading: CircularImage(
            imageUrl: widget.user.avatar,
            isNetworkImage: true,
            height: 100,
          ),
          title: Text(widget.user.userName,
              style: Theme.of(context).textTheme.titleLarge),
          trailing: const Icon(Iconsax.arrow_circle_right_copy),
        ),
      );
}
