import 'package:decordashapp/common/widgets/loaders/loaders.dart';
import 'package:decordashapp/modules/authentication/screens/gallery_selction/gallery_info.dart';
import 'package:decordashapp/modules/authentication/screens/login/login_screen.dart';
import 'package:decordashapp/modules/authentication/screens/phone_login/enter_code.dart';
import 'package:decordashapp/modules/authentication/screens/sign_up/verify_sign_up_email.dart';
import 'package:decordashapp/modules/home/screens/nav_menu.dart';
import 'package:decordashapp/modules/onboarding/screens/onboarding_screen.dart';
import 'package:decordashapp/utils/exceptions/exception_handler.dart';
import 'package:decordashapp/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:decordashapp/utils/local_storage/storage_utility.dart';
import 'package:decordashapp/utils/logging/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticatorRepo extends GetxController {
  static AuthenticatorRepo get instance => Get.find();

  final deviceStorage = GetStorage();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  User? get authUser => _auth.currentUser;
  RxString verificationId = ''.obs;

  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  screenRedirect() async {
    final user = _auth.currentUser;
    if (user != null) {
      if (user.emailVerified || user.phoneNumber != null) {
        await TLocalStorage.init(user.uid);

        deviceStorage.read('isGalleryInfoComp') != true
            ? Get.offAll(
                () => const GalleryInformationScreen(),
                duration: const Duration(milliseconds: 300),
                transition: Transition.rightToLeft,
              )
            : Get.offAll(
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
    } else {
      deviceStorage.writeIfNull('isGalleryInfoComp', false);
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

  Future<UserCredential> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      ExceptionHandler.handleAuthException(e);
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
    } catch (e) {
      ExceptionHandler.handleAuthException(e);
    }
  }

  Future<UserCredential> getPhoneUserSigninCredentials(String otp) async {
    try {
      return await _auth.signInWithCredential(
        PhoneAuthProvider.credential(
            verificationId: verificationId.value, smsCode: otp),
      );
    } catch (e) {
      ExceptionHandler.handleAuthException(e);
      rethrow;
    }
  }

  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      ExceptionHandler.handleAuthException(e);
      rethrow;
    }
  }

  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } catch (e) {
      ExceptionHandler.handleAuthException(e);
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      ExceptionHandler.handleAuthException(e);
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? userAccount = await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth =
          await userAccount?.authentication;
      final cred = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      return await _auth.signInWithCredential(cred);
    } catch (e) {
      ExceptionHandler.handleAuthException(e);
      rethrow;
    }
  }

  Future<void> reAuthEmailAndPasswordUser(String email, String password) async {
    try {
      AuthCredential cred =
          EmailAuthProvider.credential(email: email, password: password);
      await _auth.currentUser!.reauthenticateWithCredential(cred);
    } catch (e) {
      ExceptionHandler.handleAuthException(e);
    }
  }

  Future<void> deleteAccount() async {
    try {
      await _auth.currentUser?.delete();
    } catch (e) {
      ExceptionHandler.handleAuthException(e);
    }
  }

  Future<void> logOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
      Get.offAll(
        () => const LoginSignUpScreen(),
        duration: const Duration(milliseconds: 300),
        transition: Transition.upToDown,
      );
    } catch (e) {
      ExceptionHandler.handleAuthException(e);
    }
  }
}
