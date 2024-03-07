import 'package:furniture_store/utils/constants/enums.dart';
import 'package:uuid/uuid.dart';

class VendorModel {
  String id;
  String name;
  String location;
  String image;
  bool? isFeatured;
  int? productsCount;
  AccountType? accountType;

  VendorModel({
    String id = '',
    required this.image,
    required this.location,
    required this.name,
    this.isFeatured,
    this.accountType = AccountType.regular,
    this.productsCount,
  }) : id = id.isEmpty ? const Uuid().v4() : id;

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
        accountType: AccountType
            .values[data['accountType'] ?? AccountType.regular.index],
        productsCount: data['productsCount'] ?? 0);
  }
}
