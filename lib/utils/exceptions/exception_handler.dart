import 'package:decordashapp/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:decordashapp/utils/exceptions/firebase_exceptions.dart';
import 'package:decordashapp/utils/exceptions/format_exceptions.dart';
import 'package:decordashapp/utils/exceptions/platform_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class ExceptionHandler {
  static void handleAuthException(dynamic e) {
    if (e is FirebaseAuthException) {
      throw TFirebaseAuthException(e.code).message;
    } else if (e is FirebaseException) {
      throw TFirebaseException(e.code).message;
    } else if (e is FormatException) {
      throw const TFormatException();
    } else if (e is PlatformException) {
      throw TPlatformException(e.code).message;
    } else {
      throw 'Something went wrong, Please try again';
    }
  }
}
