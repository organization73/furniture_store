import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decordash/features/product/model/product_model.dart';
import 'package:decordash/utils/constants/enums.dart';

class UserModel {
  AccountType accountType;
  String firstName;
  String lastName;
  final String email;
  final String id;
  final String phoneNumber;
  bool isFeatured;
  bool isVerified;
  List<ProductModel>? wishList;
  String? username;
  String? type;
  bool? isConfirmed;
  List<ProductModel>? products;
  String imageUrl;
  // Additional fields for Vendor
  String galleryName;
  String galleryAddress;
  String galleryCertificate;

  UserModel({
    this.accountType = AccountType.regular,
    this.phoneNumber = '',
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.id = '',
    this.galleryName = '',
    this.galleryAddress = '',
    this.galleryCertificate = '',
    this.isFeatured = false,
    this.isVerified = false,
    this.wishList,
    this.type,
    this.imageUrl = "https://t4.ftcdn.net/jpg/00/65/77/27/360_F_65772719_A1UV5kLi5nCEWI0BNLLiFaBPEkUbv5Fv.jpg",
    this.isConfirmed,
    this.products,
    this.username,
  });

  String get fullName {
    return '$firstName $lastName';
  }

  String get formattedPhoneNumber {
    return phoneNumber.replaceAll(RegExp(r'\D'), '');
  }

  static List<String> nameParts(fullName) => fullName.split(' ');

  static String generateUsernameFromFullName(String fullName) {
    List<String> nameParts = fullName.split(' ');
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";

    return '$firstName$lastName';
  }

  UserModel copyWith({
    AccountType? accountType,
    String? firstName,
    String? lastName,
    String? email,
    String? id,
    String? phoneNumber,
    String? username,
    String? galleryName,
    String? galleryAddress,
    String? galleryCertificate,
    bool? isFeatured,
    bool? isVerified,
  }) {
    return UserModel(
      accountType: accountType ?? this.accountType,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      id: id ?? this.id,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      galleryName: galleryName ?? this.galleryName,
      galleryAddress: galleryAddress ?? this.galleryAddress,
      galleryCertificate: galleryCertificate ?? this.galleryCertificate,
      isFeatured: isFeatured ?? this.isFeatured,
      isVerified: isVerified ?? this.isVerified,
    );
  }

  static UserModel fromJson(Map<String, dynamic> json) {
    return UserModel(
      // accountType: EnumUtil.fromStringEnum(AccountType.values, json['accountType'] ?? ''),
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      id: json['id'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      galleryName: json['galleryName'] ?? '',
      galleryAddress: json['galleryAddress'] ?? '',
      galleryCertificate: json['galleryCertificate'] ?? '',
      isFeatured: json['isFeatured'] ?? false,
      isVerified: json['isVerified'] ?? false,
      // wishList: parseProductList(json['wishList']),
      type: json['type'] ?? '',
      imageUrl: json['imageUrl'] ?? "https://t4.ftcdn.net/jpg/00/65/77/27/360_F_65772719_A1UV5kLi5nCEWI0BNLLiFaBPEkUbv5Fv.jpg",
      isConfirmed: json['isConfirmed'] ?? false,
      // products: parseProductList(json['products']),
      username: json['username'] ?? '',
    );
  }

  static List<ProductModel>? parseProductList(dynamic jsonList) {
    if (jsonList == null) return null;
    if (jsonList is String) {
      if (jsonList.isEmpty) return [];
      return (jsonDecode(jsonList) as List<dynamic>)
          .map((json) => ProductModel.fromJson(json))
          .toList();
    } else if (jsonList is List) {
      return jsonList.map((json) => ProductModel.fromJson(json)).toList();
    } else if (jsonList is Map) {
      return [ProductModel.fromJson(jsonList as Map<String, dynamic>)];
    }
    return null;
  }

  Map<String, dynamic> toJson() {
    return {
      // 'accountType': accountType.toString().split('.').last,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'id': id,
      'phoneNumber': phoneNumber,
      'galleryName': galleryName,
      'galleryAddress': galleryAddress,
      'galleryCertificate': galleryCertificate,
      'isFeatured': isFeatured,
      'isVerified': isVerified,
      // 'wishList': wishList != null ? wishList!.map((e) => e.toJson()).toList() : [],
      'type': type,
      'imageUrl': imageUrl,
      'isConfirmed': isConfirmed,
      // 'products': products != null ? products!.map((e) => e.toJson()).toList() : [],
      'username': username,
    };
  }

  static UserModel empty() {
    return UserModel(
      accountType: AccountType.regular,
      phoneNumber: '',
      firstName: '',
      lastName: '',
      email: '',
      id: '',
      galleryName: '',
      galleryAddress: '',
      galleryCertificate: '',
      isFeatured: false,
      isVerified: false,
    );
  }

  static UserModel fromFirebaseDocument(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    if (snapshot.data() != null) {
      return UserModel(
        id: snapshot.id,
        // accountType: EnumUtil.fromStringEnum(AccountType.values, data['accountType'] ?? ''),
        imageUrl: data['imageUrl'] ?? '',
        firstName: data['firstName'] ?? '',
        lastName: data['lastName'] ?? '',
        email: data['email'] ?? '',
        phoneNumber: data['phoneNumber'] ?? '',
        galleryName: data['galleryName'] ?? '',
        galleryAddress: data['galleryAddress'] ?? '',
        galleryCertificate: data['galleryCertificate'] ?? '',
        isFeatured: data['isFeatured'] ?? false,
        isVerified: data['isVerified'] ?? false,
        wishList: parseProductList(data['wishList']),
        products: parseProductList(data['products']),
        type: data['type'],
        isConfirmed: data['isConfirmed'],
        username: data['username'],
      );
    } else {
      return UserModel.empty();
    }
  }
}
