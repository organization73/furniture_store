import 'package:decordashapp/modules/authentication/screens/user_login/user_login_screen.dart';
import 'package:decordashapp/modules/authentication/screens/signup/verify_signup_email.dart';
import 'package:decordashapp/modules/errors/screens/no_connection_screen.dart';
import 'package:decordashapp/routes/nav_menu.dart';
import 'package:decordashapp/modules/onboarding/screens/onboarding_screen.dart';
import 'package:decordashapp/utils/exceptions/exception_handler.dart';
import 'package:decordashapp/utils/helpers/network_manager.dart';
import 'package:decordashapp/utils/local_storage/storage_utility.dart';
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
  final RxString _verificationId = ''.obs;

  User? get authUser => _auth.currentUser;

  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  void screenRedirect() async {
    // Check network connectivity
    if (!NetworkManager.instance.isOnline) {
      _navigateToErrorScreen();
      return;
    }

    final user = _auth.currentUser;
    if (user != null) {
      await _handleAuthenticatedUser(user);
    } else {
      _handleUnauthenticatedUser();
    }
  }

  void _navigateToErrorScreen() {
    Get.offAll(
      () => const ErrorScreen(showActionButton: true),
    );
  }

  Future<void> _handleAuthenticatedUser(User user) async {
    if (user.emailVerified || user.phoneNumber != null) {
      await TLocalStorage.init(user.uid);
      _navigateToNavMenu();
    } else {
      _navigateToVerifySignUpEmail();
    }
  }

  void _navigateToNavMenu() {
    Get.offAll(
      () => const NavMenu(),
    );
  }

  void _navigateToVerifySignUpEmail() {
    Get.offAll(
      () => VerifySignUpEmail(
        email: _auth.currentUser?.email,
      ),
    );
  }

  void _handleUnauthenticatedUser() {
    deviceStorage.writeIfNull('isFirstTime', true);
    if (deviceStorage.read('isFirstTime') != true) {
      _navigateToUserLoginScreen();
    } else {
      _navigateToOnBoardingScreen();
    }
  }

  void _navigateToUserLoginScreen() {
    Get.offAll(
      () => const UserLoginScreen(),
    );
  }

  void _navigateToOnBoardingScreen() {
    Get.offAll(
      () => const OnBoardingScreen(),
    );
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
        },
        verificationFailed: (FirebaseAuthException e) {
          ExceptionHandler.handleAuthException(e);
        },
        codeSent: (String verificationId, int? resendToken) {
          _verificationId.value = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId.value = verificationId;
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<UserCredential> getPhoneUserSigninCredentials(String otp) async {
    try {
      return await _auth.signInWithCredential(
        PhoneAuthProvider.credential(
            verificationId: _verificationId.value, smsCode: otp),
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
        () => const UserLoginScreen(),
        transition: Transition.upToDown,
      );
    } catch (e) {
      ExceptionHandler.handleAuthException(e);
    }
  }
}
