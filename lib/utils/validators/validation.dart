import 'package:get/get.dart';

class TValidator {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'enterMail'.tr;
    }

    // Regular expression for email validation
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegExp.hasMatch(value)) {
      return 'validMail'.tr;
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'enterPass'.tr;
    }

    // Check for minimum password length
    if (value.length < 8) {
      return 'validPass'.tr;
    }

    // Check for uppercase letters
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'validPassOneUpper'.tr;
    }

    // Check for numbers
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'validPassOneNum'.tr;
    }

    // Check for special characters
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'validPassOneSpecChar'.tr;
    }

    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'enterPhone'.tr;
    } else if (!value.startsWith('01')) {
      return 'validPhone'.tr;
    } else if (!RegExp(r'^0[0-9]{10}$').hasMatch(value)) {
      return 'validPhoneLen'.tr;
    }
    return null;
  }

  static String? validateUserInput(String? value) {
    if (value == null || value.isEmpty) {
      return 'enterInput'.tr;
    }
    return null;
  }
  static String? validateGalleryName(String? value) {
    if (value == null || value.isEmpty) {
      return 'galleryVal'.tr;
    }
    return null;
  }
  static String? validateGalleryLoc(String? value) {
    if (value == null || value.isEmpty) {
      return 'galleryAddressVal'.tr;
    }
    return null;
  }
}
