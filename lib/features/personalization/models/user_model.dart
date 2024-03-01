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
