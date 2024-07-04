import 'dart:async';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decordash/features/chat/model/message.dart';
import 'package:decordash/features/personalization/controllers/user/user_controller.dart';
import 'package:decordash/features/personalization/models/user_model.dart';
import 'firebase_storage_service.dart';

class FirebaseFirestoreService {
  static final firestore = FirebaseFirestore.instance;

  static Future<void> addTextMessage({
    required String content,
    required String receiverId,
  }) async {
    final message = Message(
      content: content,
      sentTime: DateTime.now(),
      receiverId: receiverId,
      messageType: MessageType.text,
      senderId: UserController.instance.user.value.id,
    );
    await _addMessageToChat(receiverId, message);
    await _addReceiverIdToMonCollection(receiverId);
  }

  static Future<void> addImageMessage({
    required String receiverId,
    required Uint8List file,
  }) async {
    final image = await FirebaseStorageService.uploadImage(
        file, 'image/chat/${DateTime.now()}');

    final message = Message(
      content: image,
      sentTime: DateTime.now(),
      receiverId: receiverId,
      messageType: MessageType.image,
      senderId: UserController.instance.user.value.id,
    );
    await _addMessageToChat(receiverId, message);
    await _addReceiverIdToMonCollection(receiverId);
  }

  static Future<void> _addMessageToChat(
    String receiverId,
    Message message,
  ) async {
    await firestore
        .collection('Users')
        .doc(UserController.instance.user.value.id)
        .collection('chat')
        .doc(receiverId)
        .set({
      'receiverId': receiverId,
      'lastMessage': message.toJson(),
    });
    await firestore
        .collection('Users')
        .doc(UserController.instance.user.value.id)
        .collection('chat')
        .doc(receiverId)
        .set({
      'receiverId': receiverId,
      'lastMessage': message.toJson(),
    });
    await firestore
        .collection('Users')
        .doc(UserController.instance.user.value.id)
        .collection('chat')
        .doc(receiverId)
        .collection('messages')
        .add(message.toJson());

    await firestore
        .collection('Users')
        .doc(receiverId)
        .collection('chat')
        .doc(UserController.instance.user.value.id)
        .collection('messages')
        .add(message.toJson());
  }

  static Future<void> _addReceiverIdToMonCollection(String receiverId) async {
    await firestore
        .collection('UserChats')
        .doc(UserController.instance.user.value.id)
        .collection('receivers')
        .doc(receiverId)
        .set({'receiverId': receiverId});
    await firestore
        .collection('UserChats')
        .doc(receiverId)
        .collection('receivers')
        .doc(UserController.instance.user.value.id)
        .set({'receiverId': receiverId});
  }

  static Future<List<UserModel>> searchUser(String name) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('Users')
        .where("userName", isGreaterThanOrEqualTo: name)
        .get();

    return snapshot.docs
        .map((doc) => UserModel.fromJsonForFireBase(doc.data()))
        .toList();
  }
}
