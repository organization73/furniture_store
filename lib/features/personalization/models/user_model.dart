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
  final String userName;
  DateTime? createdDate;

  // Additional fields for Vendor
  String galleryName;
  String galleryAddress;
  String galleryCertificate ;

  UserModel({
    this.accountType = AccountType.regular,
    this.phoneNumber = '',
    this.avatar = '',
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.id = '',
    this.userName = '',
    DateTime? createdDate,
    this.galleryName = '',
    this.galleryAddress = '',
    this.galleryCertificate = '',
  }) : createdDate = createdDate ?? DateTime.now();
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
    String? galleryName,
    String? galleryAddress,
    String? galleryCertificate,
  }) {
    return UserModel(
      accountType: accountType ?? this.accountType,
      avatar: avatar ?? this.avatar,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      id: id ?? this.id,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      userName: userName ?? this.userName,
      createdDate: createdDate ?? this.createdDate,
      galleryName: galleryName ?? this.galleryName,
      galleryAddress: galleryAddress ?? this.galleryAddress,
      galleryCertificate: galleryCertificate ?? this.galleryCertificate,
    );
  }

  static UserModel fromJson(Map<String, dynamic> json) {
    return UserModel(
      accountType:
          EnumUtil.fromStringEnum(AccountType.values, json['accountType']),
      avatar: json['avatar'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      id: json['id'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      userName: json['userName'] ?? '',
      createdDate: json['createdDate'] != null
          ? (json['createdDate'] as Timestamp).toDate()
          : null,
      galleryName: json['galleryName'] ?? '',
      galleryAddress: json['galleryAddress'] ?? '',
      galleryCertificate: json['galleryCertificate'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accountType': accountType.toString().split('.').last,
      'avatar': avatar,
      'firstName': firstName,
      'lastName': lastName,
      'userName': userName,
      'createdDate': Timestamp.fromDate(createdDate ?? DateTime.now()),
      'email': email,
      'phoneNumber': phoneNumber,
      'id': id,
      'galleryName': galleryName,
      'galleryAddress': galleryAddress,
      'galleryCertificate': galleryCertificate,
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
      userName: '',
      createdDate: DateTime.now(),
      galleryName: '',
      galleryAddress: '',
      galleryCertificate: '',
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
        userName: data['userName'] ?? '',
        createdDate: data['createdDate'] != null
            ? (data['createdDate'] as Timestamp).toDate()
            : null,
        galleryName: data['galleryName'] ?? '',
        galleryAddress: data['galleryAddress'] ?? '',
        galleryCertificate: data['galleryCertificate'] ?? '',
      );
    } else {
      return UserModel.empty();
    }
  }
}
