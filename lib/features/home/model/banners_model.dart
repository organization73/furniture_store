import 'package:cloud_firestore/cloud_firestore.dart';

class BannersModel {
  final String image;
  final bool active;

  BannersModel({
    required this.image,
    required this.active,
  });

  static BannersModel empty() => BannersModel(
        image: '',
        active: false,
      );

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'active': active,
    };
  }

  factory BannersModel.fromFirebaseDocument(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    if (snapshot.data() != null) {
      return BannersModel(
        image: data['image'] ?? '',
        active: data['active'] ?? false,
      );
    } else {
      return BannersModel.empty();
    }
  }
}
