import 'package:decordashapp/common/widgets/images/circular_image.dart';
import 'package:decordashapp/modules/chat/screens/chat_screen.dart';
import 'package:decordashapp/modules/personalization/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class UserItem extends StatelessWidget {
  const UserItem({super.key, required this.user});

  final UserModel user;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => Get.to(
          () => ChatScreen(userId: user.id),
          duration: const Duration(milliseconds: 300),
          transition: Transition.downToUp,
        ),
        child: ListTile(
          leading: CircularImage(
            imageUrl: user.avatar,
            isNetworkImage: true,
          ),
          title: Text(user.userName,
              style: Theme.of(context).textTheme.titleMedium),
          trailing: const Icon(IconsaxPlusLinear.arrow_circle_right),
        ),
      );
}
