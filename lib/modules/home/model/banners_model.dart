import 'package:cloud_firestore/cloud_firestore.dart';

class BannersModel {
  late final String image;
  final bool active;
  final String targetScreen;

  BannersModel({
    required this.image,
    required this.active,
    required this.targetScreen,
  });

  static BannersModel empty() => BannersModel(
        image: '',
        active: false,
        targetScreen: '',
      );

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'active': active,
      'targetScreen': targetScreen,
    };
  }

  factory BannersModel.fromFirebaseDocument(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    if (snapshot.data() != null) {
      return BannersModel(
        image: data['image'] ?? '',
        active: data['active'] ?? false,
        targetScreen: data['targetScreen'] ?? '',
      );
    } else {
      return BannersModel.empty();
    }
  }
}
