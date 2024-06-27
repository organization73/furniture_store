import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decordash/utils/constants/enums.dart';

class UserModel {
  AccountType accountType;
  String avatar;
  String firstName;
  String lastName;
  final String email;
  final String id;
  final String phoneNumber;
  DateTime? createdDate;
  DateTime? lastActive;
  bool isOnline;
  bool isFeatured;
  bool isVerified;
  List<Products>? wishList;
  String? sId;
  String? firstNameNew;
  String? lastNameNew;
  String? username;
  String? type;
  String? emailNew;
  String? phoneNumberNew;
  bool? isConfirmed;
  List<Products>? products;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? imageUrl;
  // Additional fields for Vendor
  String galleryName;
  String galleryAddress;
  String galleryCertificate;

  UserModel({
    this.accountType = AccountType.regular,
    this.phoneNumber = '',
    this.avatar = '',
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.id = '',
    this.lastActive,
    this.isOnline = false,
    this.galleryName = '',
    this.galleryAddress = '',
    this.galleryCertificate = '',
    this.isFeatured = false,
    this.isVerified = false,
    this.wishList,
    this.sId,
    this.firstNameNew,
    this.lastNameNew,
    this.type,
    this.emailNew,
    this.phoneNumberNew,
    this.iV,
    this.imageUrl,
    this.isConfirmed,
    this.products,
    this.username
  });
  String get fullName {
    return '$firstName $lastName';
  }

  String get formattedPhoneNumber {
    return phoneNumber.replaceAll(RegExp(r'\D'), '');
  }

  static List<String> nameParts(fullName) => fullName.split(' ');

  static String generateUsernameFromFullName(String fullName) {
    // Split the full name into parts
    List<String> nameParts = fullName.split(' ');
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";

    return '$firstName$lastName';
  }

  UserModel copyWith({
    AccountType? accountType,
    String? avatar,
    String? firstName,
    String? lastName,
    String? email,
    String? id,
    String? phoneNumber,
    String? userName,
    DateTime? createdDate,
    DateTime? lastActive,
    bool? isOnline,
    String? galleryName,
    String? galleryAddress,
    String? galleryCertificate,
    bool? isFeatured,
    bool? isVerified,
  }) {
    return UserModel(
      accountType: accountType ?? this.accountType,
      avatar: avatar ?? this.avatar,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      id: id ?? this.id,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      lastActive: lastActive ?? this.lastActive,
      isOnline: isOnline ?? this.isOnline,
      galleryName: galleryName ?? this.galleryName,
      galleryAddress: galleryAddress ?? this.galleryAddress,
      galleryCertificate: galleryCertificate ?? this.galleryCertificate,
      isFeatured: isFeatured ?? this.isFeatured,
      isVerified: isVerified ?? this.isVerified,
    );
  }

  static UserModel fromJson(Map<String, dynamic> json) {
    return UserModel(
      // accountType:
      //     EnumUtil.fromStringEnum(AccountType.values, json['accountType']),
      avatar: json['avatar'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      id: json['id'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      // lastActive: json['lastActive'] != null
      //     ? (json['lastActive'] as Timestamp).toDate()
      //     : DateTime.now(),
      isOnline: json['isOnline'] ?? false,
      galleryName: json['galleryName'] ?? '',
      galleryAddress: json['galleryAddress'] ?? '',
      galleryCertificate: json['galleryCertificate'] ?? '',
      isFeatured: json['isFeatured'] ?? false,
      isVerified: json['isVerified'] ?? false,
      wishList: json['wishList'] != null
          ? (json['wishList']['items'] as List)
              .map((x) => Products.fromJson(x as Map<String, dynamic>))
              .toList()
          : [],
      sId: json['sId'],
      firstNameNew: json['firstNameNew'],
      lastNameNew: json['lastNameNew'],
      type: json['type'],
      emailNew: json['emailNew'],
      phoneNumberNew: json['phoneNumberNew'],
      isConfirmed: json['isConfirmed'],
      products: json['products'] != null
          ? List<Products>.from(
              json['products'].map((x) => Products.fromJson(x)))
          : null,
      iV: json['iV'],
      imageUrl: json['imageUrl'],
      username:json['username']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accountType': accountType.toString().split('.').last,
      'avatar': avatar,
      'firstName': firstName,
      'lastName': lastName,
      'isOnline': isOnline,
      'email': email,
      'phoneNumber': phoneNumber,
      'id': id,
      'galleryName': galleryName,
      'galleryAddress': galleryAddress,
      'galleryCertificate': galleryCertificate,
      'isFeatured': isFeatured,
      'isVerified': isVerified,
      'username':username
    };
  }

  static UserModel empty() {
    return UserModel(
      accountType: AccountType.regular,
      phoneNumber: '',
      avatar: '',
      firstName: '',
      lastName: '',
      email: '',
      id: '',
      lastActive: DateTime.now(),
      isOnline: false,
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
        accountType: EnumUtil.fromStringEnum(
            AccountType.values, data['accountType'] ?? ''),
        avatar: data['avatar'] ?? '',
        firstName: data['firstName'] ?? '',
        lastName: data['lastName'] ?? '',
        email: data['email'] ?? '',
        phoneNumber: data['phoneNumber'] ?? '',
        lastActive: data['lastActive'] != null
            ? (data['lastActive'] as Timestamp).toDate()
            : DateTime.now(),
        isOnline: data['isOnline'] ?? false,
        galleryName: data['galleryName'] ?? '',
        galleryAddress: data['galleryAddress'] ?? '',
        galleryCertificate: data['galleryCertificate'] ?? '',
        isFeatured: data['isFeatured'] ?? false,
        isVerified: data['isVerified'] ?? false,
      );
    } else {
      return UserModel.empty();
    }
  }
}

class Products {
  String? sId;
  Products({this.sId});
  Products.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    return data;
  }
}
