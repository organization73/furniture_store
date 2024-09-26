import 'package:cloud_firestore/cloud_firestore.dart';

class VendorCategoryModel {
  final String vendorId;
  final String categoryId;
  VendorCategoryModel({required this.vendorId, required this.categoryId});

Map<String, dynamic> toJson() => {
        'vendorId': vendorId,
        'categoryId': categoryId,
      };

  factory VendorCategoryModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return VendorCategoryModel(
      vendorId: data['vendorId'] as String,
      categoryId: data['categoryId'] as String,
    );
  }
}
