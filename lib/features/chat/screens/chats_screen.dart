import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decordash/data/services/firebase_firestore_service.dart';
import 'package:decordash/data/services/notification_service.dart';
import 'package:decordash/features/chat/screens/search_screen.dart';
import 'package:decordash/features/chat/controllers/chat_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> with WidgetsBindingObserver {
  final notificationService = NotificationsService();
  final chatController = Get.put(ChatController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    notificationService.firebaseNotification(context);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        FirebaseFirestoreService.updateUserData({
          'lastActive': DateTime.now(),
          'isOnline': true,
        });
        break;

      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        FirebaseFirestoreService.updateUserData({'isOnline': false});
        break;
      case AppLifecycleState.hidden:
      // TODO: Handle this case.
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Chats'),
          actions: [
            IconButton(
              onPressed: () => Get.to(
                () => const UsersSearchScreen(),
                duration: const Duration(milliseconds: 300),
                transition: Transition.rightToLeft,
              ),
              icon: const Icon(
                Iconsax.search_normal_copy,
              ),
            ),
          ],
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('chat')
              .snapshots(includeMetadataChanges: true),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            final chatDocs = snapshot.data!.docs;
            if (chatDocs.isEmpty) {
              return const Center(child: Text('No Chats Found'));
            }
            return ListView.builder(
              itemCount: chatDocs.length,
              itemBuilder: (context, index) {
                final chatDoc = chatDocs[index];
                // Extract data from chatDoc as needed
                // For example, you can access document ID using chatDoc.id
                return ListTile(
                  title: Text(chatDoc.id), // Displaying document ID
                  // Customize as needed based on the data in chatDoc
                );
              },
            );
          },
        ),
      );
}
