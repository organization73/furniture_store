import 'package:furniture_store/utils/constants/enums.dart';

class VendorModel {
  String id;
  String name;
  String location;
  String image;
  bool? isFeatured;
  int? productsCount;
  AccountType? accountType;

  VendorModel({
    required this.id,
    required this.image,
    required this.location,
    required this.name,
    this.isFeatured,
    this.accountType = AccountType.regular,
    this.productsCount,
  });

  static VendorModel empty() => VendorModel(
      id: '',
      image: '',
      name: '',
      location: '',
      accountType: AccountType.regular);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'isFeatured': isFeatured,
      'productsCount': productsCount,
      'location': location,
      'accountType': accountType?.index, // Assuming AccountType is an enum
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
        accountType: AccountType.values[data['accountType'] ??
            AccountType.regular.index], // Convert index back to enum
        productsCount: data['productsCount'] ?? 0);
  }
}
