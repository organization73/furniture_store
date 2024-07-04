import 'dart:typed_data';
import 'package:decordash/common/widgets/input_fields/custom_text_form_field.dart';
import 'package:decordash/common/widgets/loaders/loaders.dart';
import 'package:decordash/data/services/firebase_firestore_service.dart';
import 'package:decordash/data/services/media_service.dart';
import 'package:decordash/features/chat/controllers/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ChatTextField extends StatefulWidget {
  const ChatTextField({super.key, required this.receiverId});

  final String receiverId;

  @override
  State<ChatTextField> createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends State<ChatTextField> {
  final controller = TextEditingController();
  // final notificationsService = NotificationsService();

  Uint8List? file;

  @override
  void initState() {
    // notificationsService.getReceiverToken(widget.receiverId);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Expanded(
            child: CustomTextFormField(
              controller: controller,
              hint: 'Add Message...',
              prefixIcon: Iconsax.message_add_copy,
            ),
          ),
          SizedBox(width: 5.w),
          IconButton.filledTonal(
              onPressed: () => _sendText(context),
              icon: const Icon(Iconsax.send_1)),
          SizedBox(width: 5.w),
          IconButton.filledTonal(
              onPressed: () => _sendImage(), icon: const Icon(Iconsax.image)),
        ],
      );

  Future<void> _sendText(BuildContext context) async {
    if (controller.text.isNotEmpty) {
      await FirebaseFirestoreService.addTextMessage(
        receiverId: widget.receiverId,
        content: controller.text,
      );
      // await notificationsService.sendNotification(
      //   body: controller.text,
      //   senderId: FirebaseAuth.instance.currentUser!.uid,
      // );
      controller.clear();
      // FocusScope.of(Get.context!).unfocus();
    } else {
      TLoaders.warningSnackBar(title: "please provide a message");
    }
    // FocusScope.of(Get.context!).unfocus();
    ChatController.instance.scrollDown();
  }

  Future<void> _sendImage() async {
    final pickedImage = await MediaService.pickImage();
    setState(() => file = pickedImage);
    if (file != null) {
      await FirebaseFirestoreService.addImageMessage(
        receiverId: widget.receiverId,
        file: file!,
      );
      // await notificationsService.sendNotification(
      //   body: 'image recieved',
      //   senderId: FirebaseAuth.instance.currentUser!.uid,
      // );
      ChatController.instance.scrollDown();
    }
  }
}
