import 'package:decordashapp/common/widgets/input_fields/custom_text_form_field.dart';
import 'package:decordashapp/data/services/chat/firebase_chat_service.dart';
import 'package:decordashapp/data/services/cloud_storage/firebase_storage_service.dart';
import 'package:decordashapp/data/services/chat/notifications/notification_service.dart';
import 'package:decordashapp/modules/chat/controllers/chat_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:image_picker/image_picker.dart';

class ChatTextField extends StatefulWidget {
  const ChatTextField({super.key, required this.receiverId});

  final String receiverId;

  @override
  State<ChatTextField> createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends State<ChatTextField> {
  final controller = TextEditingController();
  final notificationsService = NotificationsService();
  XFile? file;

  @override
  void initState() {
    notificationsService.getReceiverToken(widget.receiverId);
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
              prefixIcon: IconsaxPlusLinear.message_add,
            ),
          ),
          const SizedBox(width: 5),
          IconButton.filledTonal(
              onPressed: () => _sendText(context),
              icon: const Icon(IconsaxPlusLinear.send_1)),
          const SizedBox(width: 5),
          IconButton.filledTonal(
              onPressed: () => _sendImage(),
              icon: const Icon(IconsaxPlusLinear.image)),
        ],
      );

  Future<void> _sendText(BuildContext context) async {
    if (controller.text.isNotEmpty) {
      await FirebaseFirestoreService.addTextMessage(
        receiverId: widget.receiverId,
        content: controller.text,
      );
      await notificationsService.sendNotification(
        body: controller.text,
        senderId: FirebaseAuth.instance.currentUser!.uid,
      );
      controller.clear();
      // FocusScope.of(Get.context!).unfocus();
    }
    // FocusScope.of(Get.context!).unfocus();
    ChatController.instance.scrollDown();
  }

  Future<void> _sendImage() async {
    // final pickedImage = await MediaService.pickImage();
    // setState(() => file = pickedImage as XFile?);
    Get.put(FirebaseStorageServices());
    final pickedImage = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxHeight: 512,
        maxWidth: 512);
    setState(() => file = pickedImage);
    if (file != null) {
      await FirebaseFirestoreService.addImageMessage(
        receiverId: widget.receiverId,
        file: file!,
      );
      await notificationsService.sendNotification(
        body: 'image recieved',
        senderId: FirebaseAuth.instance.currentUser!.uid,
      );
      ChatController.instance.scrollDown();
    }
  }
}
