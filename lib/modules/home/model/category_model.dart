import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String id;
  String name;
  String image;
  String parentId;
  bool isFeatured;
  bool isRoom;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    required this.isFeatured,
    this.parentId = '',
    this.isRoom = false,
  });

  static CategoryModel empty() => CategoryModel(
        id: '',
        image: '',
        isFeatured: false,
        isRoom: false,
        name: '',
        parentId: '',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'image': image,
        'parentId': parentId,
        'isFeatured': isFeatured,
        'isRoom': isRoom,
      };

  factory CategoryModel.fromFirebaseDocument(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    if (snapshot.data() != null) {
      return CategoryModel(
        id: snapshot.id,
        name: data['name'] ?? '',
        image: data['image'] ?? '',
        parentId: data['parentId'] ?? '',
        isFeatured: data['isFeatured'] ?? false,
        isRoom: data['isRoom'] ?? false,
      );
    } else {
      return CategoryModel.empty();
    }
  }
}
