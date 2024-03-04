import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:furniture_store/utils/constants/enums.dart';

class UserModel {
  final AccountType accountType;
  final List<SimpleGrantedAuthority> authorities;
  String avatar;
  String firstName;
  String lastName;
  final String confirmCode;
  final String createdDate;
  final String email;
  final String id;
  final String kcyAddress;
  final bool verified;
  final AccountState state;
  final String password;
  final Roles roles;
  String phoneNumber;
  final String userName;

  UserModel({
    this.accountType = AccountType.regular, // Default value
    this.phoneNumber = '', // Default value for the phone number
    this.authorities = const [], // Default value
    this.avatar = '', // Default value
    this.firstName = '', // Default value
    this.lastName = '', // Default value
    this.email = '', // Default value
    this.id = '', // Default value
    this.password = '', // Default value
    this.confirmCode = '', // Default value
    this.state = AccountState.active, // Default value
    this.createdDate = '', // Default value
    this.kcyAddress = '', // Default value
    this.verified = false, // Default value
    this.roles = Roles.user, // Default value
    this.userName = '',
  });
  String get fullName {
    return '$firstName $lastName';
  }

  String get formattedPhoneNumber {
    return phoneNumber.replaceAll(
        RegExp(r'\D'), ''); // Remove non-numeric characters
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
    List<SimpleGrantedAuthority>? authorities,
    String? avatar,
    String? firstName,
    String? lastName,
    String? confirmCode,
    String? createdDate,
    String? email,
    String? id,
    String? kcyAddress,
    bool? verified,
    AccountState? state,
    String? password,
    Roles? roles,
    String? phoneNumber,
    String? userName,
  }) {
    return UserModel(
      accountType: accountType ?? this.accountType,
      authorities: authorities ?? this.authorities,
      avatar: avatar ?? this.avatar,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      confirmCode: confirmCode ?? this.confirmCode,
      createdDate: createdDate ?? this.createdDate,
      email: email ?? this.email,
      id: id ?? this.id,
      kcyAddress: kcyAddress ?? this.kcyAddress,
      verified: verified ?? this.verified,
      state: state ?? this.state,
      password: password ?? this.password,
      roles: roles ?? this.roles,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      userName: userName ?? this.userName,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      accountType:
          EnumUtil.fromStringEnum(AccountType.values, json['accountType']),
      authorities: json['authorities']
          .map<SimpleGrantedAuthority>(
              (item) => SimpleGrantedAuthority.fromJson(item))
          .toList(),
      avatar: json['avatar'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      confirmCode: json['confirmCode'],
      email: json['email'],
      password: json['password'],
      verified: json['verified'] ?? false,
      id: json['id'],
      kcyAddress: json['kcyAddress'],
      state: EnumUtil.fromStringEnum(AccountState.values, json['state']),
      roles: EnumUtil.fromStringEnum(Roles.values, json['roles']),
      createdDate: json['createdDate'],
      phoneNumber: json['phoneNumber'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accountType': accountType.toString().split('.').last,
      'authorities':
          authorities.map((authority) => authority.toJson()).toList(),
      'avatar': avatar,
      'firstName': firstName,
      'lastName': lastName,
      'confirmCode': confirmCode,
      'createdDate': createdDate,
      'email': email,
      'phoneNumber': phoneNumber,
      'id': id,
      'kcyAddress': kcyAddress,
      'verified': verified,
      'state': state.toString().split('.').last,
      'password': password,
      'roles': roles.toString().split('.').last,
    };
  }

  static UserModel empty() {
    return UserModel(
      accountType: AccountType.regular, // Default value
      phoneNumber: '', // Default value for the phone number
      authorities: const [], // Default value
      avatar: '', // Default value
      firstName: '', // Default value
      lastName: '', // Default value
      email: '', // Default value
      id: '', // Default value
      password: '', // Default value
      confirmCode: '', // Default value
      state: AccountState.active, // Default value
      createdDate: '', // Default value
      kcyAddress: '', // Default value
      verified: false, // Default value
      roles: Roles.user, // Default value
      userName: '',
    );
  }

  factory UserModel.fromFirebaseDocument(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    if (snapshot.data() != null) {
      return UserModel(
        accountType:
            EnumUtil.fromStringEnum(AccountType.values, data['accountType']),
        authorities: (data['authorities'] as List)
            .map<SimpleGrantedAuthority>(
                (item) => SimpleGrantedAuthority.fromJson(item))
            .toList(),
        avatar: data['avatar'],
        firstName: data['firstName'],
        lastName: data['lastName'],
        confirmCode: data['confirmCode'],
        email: data['email'],
        password: data['password'],
        verified: data['verified'],
        id: snapshot.id, // Use the document ID as the user ID
        kcyAddress: data['kcyAddress'],
        state: EnumUtil.fromStringEnum(AccountState.values, data['state']),
        roles: EnumUtil.fromStringEnum(Roles.values, data['roles']),
        createdDate: data['createdDate'],
        phoneNumber: data[
            'phoneNumber'], // Assuming the phone number is stored in the document
      );
    } else {
      return UserModel.empty();
    }
  }
}

class SimpleGrantedAuthority {
  final String authority;

  SimpleGrantedAuthority({required this.authority});

  factory SimpleGrantedAuthority.fromJson(Map<String, dynamic> json) {
    return SimpleGrantedAuthority(
      authority: json['authority'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'authority': authority,
    };
  }
}
