import 'package:decordash/common/widgets/loaders/loaders.dart';
import 'package:decordash/data/repositories/authentication/api_services.dart';
import 'package:decordash/features/authentication/screens/sign_in_with_phone/enter_code.dart';
import 'package:decordash/features/personalization/controllers/user/user_controller.dart';
import 'package:decordash/utils/local_storage/storage_utility.dart';
import 'package:decordash/utils/logging/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:decordash/data/repositories/user/user_repo.dart';
import 'package:decordash/features/authentication/screens/login/login_screen.dart';
import 'package:decordash/features/authentication/screens/sign_up/verify_sign_up_email.dart';
import 'package:decordash/features/home/screens/nav_menu.dart';
import 'package:decordash/features/onboarding/screens/onboarding_screen.dart';
import 'package:decordash/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:decordash/utils/exceptions/firebase_exceptions.dart';
import 'package:decordash/utils/exceptions/format_exceptions.dart';
import 'package:decordash/utils/exceptions/platform_exceptions.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticatorRepo extends GetxController {
  static AuthenticatorRepo get instance => Get.find();

  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  User? get authUser => _auth.currentUser;
  RxString verificationId = ''.obs;
  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  screenRedirect() async {
    var userController = UserController.instance;
    final con = Get.put(UserController());
    // con.loadUserData();
    LoggerHelper.info(userController.user.value.firstName);
    final user = _auth.currentUser;
    if (user != null) {
      if (user.emailVerified || user.phoneNumber != null) {
        await TLocalStorage.init(user.uid);

        Get.offAll(
          () => const NavMenu(),
          duration: const Duration(milliseconds: 300),
          transition: Transition.rightToLeft,
        );
      } else {
        Get.offAll(
          () => VerifySignUpEmail(
            email: _auth.currentUser?.email,
          ),
          duration: const Duration(milliseconds: 300),
          transition: Transition.rightToLeft,
        );
      }
    } else if (userController.user.value.firstName.isNotEmpty) {
      Get.offAll(
        () => const NavMenu(),
        duration: const Duration(milliseconds: 300),
        transition: Transition.rightToLeft,
      );
    } else {
      deviceStorage.writeIfNull('isFirstTime', true);
      deviceStorage.read('isFirstTime') != true
          ? Get.offAll(
              () => const LoginSignUpScreen(),
              duration: const Duration(milliseconds: 300),
              transition: Transition.rightToLeft,
            )
          : Get.offAll(
              () => const OnBoardingScreen(),
              duration: const Duration(milliseconds: 300),
              transition: Transition.rightToLeft,
            );
    }
  }

  Future<Map<String, dynamic>> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      final response = await HttpService.instance.loginUser(email, password);
      final token = response['token'];
      deviceStorage.write('token', token);
      deviceStorage.write('isConfirmed', true);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> checkIsConfirmed(String email) async {
    try {
      final response = await HttpService.instance.checkIsConfirmed(email);
      final isConfirmed = response['isConfirmed'];
      print(isConfirmed);
      if (isConfirmed) {
        GetStorage().write('token', response['token']);
      }
      LoggerHelper.error(response.toString());
      // updateUserVerificationStatus(isConfirmed);
      return response;
    } catch (e) {
      LoggerHelper.error('Error checking email verification status', e);
      rethrow;
    }
  }

  Future<void> loginWithPhone(String phoneNum) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNum,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          Get.to(
            () => CodeVerificationScreen(
              phoneNumber: phoneNum,
            ),
            duration: const Duration(milliseconds: 300),
            transition: Transition.rightToLeft,
          );
        },
        verificationFailed: (FirebaseAuthException e) {
          LoggerHelper.error('Error verifying phone number', e);
          TLoaders.errorSnackBar(
              title: 'ohSnap'.tr,
              message: TFirebaseAuthException(e.code).message);

          throw TFirebaseAuthException(e.code).message;
        },
        codeSent: (String verificationId, int? resendToken) {
          this.verificationId.value = verificationId;
          Get.to(
            () => CodeVerificationScreen(
              phoneNumber: phoneNum,
            ),
            duration: const Duration(milliseconds: 300),
            transition: Transition.rightToLeft,
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          this.verificationId.value = verificationId;
        },
      );
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserCredential> getPhoneUserSigninCredentials(String otp) async {
    try {
      UserCredential credentials = await _auth.signInWithCredential(
          PhoneAuthProvider.credential(
              verificationId: verificationId.value, smsCode: otp));
      return credentials;
    } catch (e) {
      LoggerHelper.error('error', e);
      throw 'Something went wrong, Please try again';
    }
  }

  Future<void> registerWithEmailAndPassword(String firstName, String lastName,
      String username, String phoneNum, String email, String password) async {
    try {
      await HttpService.instance
          .signUpUser(firstName, lastName, username, phoneNum, email, password);
      deviceStorage.write('token', '');
    } catch (e) {
      rethrow;
    }
  }

  Future<void> sendEmailVerification(String email) async {
    try {
      await HttpService.instance.senEmailVerification(email);
    } catch (e) {
      rethrow;
    }
    // TODO resend code
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await userAccount?.authentication;

      final cred = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      return await _auth.signInWithCredential(cred);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }

  Future<void> reAuthEmailAndPasswordUser(String email, String password) async {
    try {
      AuthCredential cred =
          EmailAuthProvider.credential(email: email, password: password);

      await _auth.currentUser!.reauthenticateWithCredential(cred);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }

  Future<void> deleteAccount() async {
    try {
      await UserRepo.instance.removeUserRecord(_auth.currentUser!.uid);
      await _auth.currentUser?.delete();
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }

  Future<void> logOut() async {
    try {
      UserController.instance.removeUserData();

      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      Get.offAll(
        () => const LoginSignUpScreen(),
        duration: const Duration(milliseconds: 300),
        transition: Transition.upToDown,
      );
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }
}
