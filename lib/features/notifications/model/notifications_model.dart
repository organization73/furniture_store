import 'package:cloud_firestore/cloud_firestore.dart';

class Notifications {
  String? title;
  String? subtitle;
  final Timestamp timestamp;

  Notifications({this.title, this.subtitle, required this.timestamp});

  factory Notifications.fromMap(Map<String, dynamic> data) => Notifications(
        title: data['title'] as String?,
        subtitle: data['subtitle'] as String?,
        timestamp: data['timestamp'] as Timestamp,
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'subtitle': subtitle,
        'timestamp': timestamp,
      };

  factory Notifications.fromFirebaseDocument(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Notifications(
      title: data['title'] as String?,
      subtitle: data['subtitle'] as String?,
      timestamp: data['timestamp'] as Timestamp,
    );
  }
}
