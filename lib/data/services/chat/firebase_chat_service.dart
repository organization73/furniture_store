import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decordashapp/data/services/cloud_storage/firebase_storage_service.dart';
import 'package:decordashapp/modules/chat/model/chat_message_model.dart';
import 'package:decordashapp/modules/profile/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

class FirebaseFirestoreService {
  static final firestore = FirebaseFirestore.instance;

  static Future<void> addTextMessage({
    required String content,
    required String receiverId,
  }) async {
    final message = ChatMessageModel(
      content: content,
      sentTime: DateTime.now(),
      receiverId: receiverId,
      messageType: MessageType.text,
      senderId: FirebaseAuth.instance.currentUser!.uid,
    );
    await _addMessageToChat(receiverId, message);
    await _addReceiverIdToMonCollection(receiverId);
  }

  static Future<void> addImageMessage({
    required String receiverId,
    required XFile file,
  }) async {
    final image = await FirebaseStorageServices.instance
        .uploadImageFile('image/chat/${DateTime.now()}', file);

    final message = ChatMessageModel(
      content: image,
      sentTime: DateTime.now(),
      receiverId: receiverId,
      messageType: MessageType.image,
      senderId: FirebaseAuth.instance.currentUser!.uid,
    );
    await _addMessageToChat(receiverId, message);
    await _addReceiverIdToMonCollection(receiverId);
  }

  static Future<void> _addMessageToChat(
    String receiverId,
    ChatMessageModel message,
  ) async {
    await firestore
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('chat')
        .doc(receiverId)
        .collection('messages')
        .add(message.toJson());

    await firestore
        .collection('Users')
        .doc(receiverId)
        .collection('chat')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('messages')
        .add(message.toJson());
  }

  static Future<void> _addReceiverIdToMonCollection(String receiverId) async {
    await firestore
        .collection('UserChats')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('receivers')
        .doc(receiverId)
        .set({'receiverId': receiverId});
    await firestore
        .collection('UserChats')
        .doc(receiverId)
        .collection('receivers')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({'receiverId': FirebaseAuth.instance.currentUser!.uid});
  }

  static Future<List<UserModel>> searchUser(String name) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('Users')
        .where("userName", isGreaterThanOrEqualTo: name)
        .get();

    return snapshot.docs.map((doc) => UserModel.fromJson(doc.data())).toList();
  }
}
