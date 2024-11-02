import 'package:cloud_firestore/cloud_firestore.dart';

class RoomModel {
  final String id;
  final String name;
  String image;

  RoomModel({
    required this.id,
    required this.name,
    required this.image,
  });

  static RoomModel empty() => RoomModel(
        id: '',
        image: '',
        name: '',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'image': image,
      };

  factory RoomModel.fromFirebaseDocument(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    if (snapshot.data() != null) {
      return RoomModel(
        id: snapshot.id,
        name: data['name'] ?? '',
        image: data['image'] ?? '',
      );
    } else {
      return RoomModel.empty();
    }
  }
}
