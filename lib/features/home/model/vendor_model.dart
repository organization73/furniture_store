import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:furniture_store/utils/constants/enums.dart';
import 'package:uuid/uuid.dart';

class VendorModel {
  String id;
  String name;
  String location;
  String image;
  bool? isFeatured;
  bool? isVerified;
  int? productsCount;
  AccountType? accountType;

  VendorModel({
    String id = '',
    required this.image,
    required this.location,
    required this.name,
    this.isFeatured = false,
    this.isVerified = false,
    this.accountType = AccountType.regular,
    this.productsCount,
  }) : id = id.isEmpty ? const Uuid().v4() : id;

  static VendorModel empty() => VendorModel(
      id: '',
      image: '',
      name: '',
      location: '',
      isFeatured: false,
      isVerified: false,
      productsCount: 0,
      accountType: AccountType.regular);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'isFeatured': isFeatured,
      'isVerified': isVerified,
      'productsCount': productsCount,
      'location': location,
      'accountType': accountType?.index,
    };
  }

  factory VendorModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) return VendorModel.empty();
    return VendorModel(
        id: data['id'] ?? '',
        image: data['image'] ?? '',
        name: data['name'] ?? '',
        location: data['location'] ?? '',
        isFeatured: data['isFeatured'] ?? false,
        isVerified: data['isVerified'] ?? false,
        accountType: AccountType
            .values[data['accountType'] ?? AccountType.regular.index],
        productsCount: data['productsCount'] ?? 0);
  }
  factory VendorModel.fromFirebaseDocument(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    if (snapshot.exists) {
      return VendorModel(
          id: snapshot.id,
          image: data['image'] ?? '',
          name: data['name'] ?? '',
          location: data['location'] ?? '',
          isFeatured: data['isFeatured'] ?? false,
          isVerified: data['isVerified'] ?? false,
          accountType: AccountType
              .values[data['accountType'] ?? AccountType.regular.index],
          productsCount: data['productsCount'] ?? 0);
    } else {
      return VendorModel.empty();
    }
  }
}
