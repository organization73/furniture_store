import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:furniture_store/data/repositories/authentication/api_services.dart';
import 'package:furniture_store/features/authentication/screens/login/login_screen.dart';
import 'package:furniture_store/features/authentication/screens/sign_up/verify_sign_up_email.dart';
import 'package:furniture_store/features/home/screens/nav_menu.dart';
import 'package:furniture_store/features/onboarding/screens/onboarding_screen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthenticatorRepoTest extends GetxController {
  static AuthenticatorRepoTest get instance => Get.find();

  final deviceStorage = GetStorage();

  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  screenRedirect() async {
    final token = deviceStorage.read('token');
    final isConfirmed = deviceStorage.read('isConfirmed');
    print("is confirmed $isConfirmed");
    print("token $token");

    if (token != null) {
      // User is logged in, navigate to the home screen
      if (isConfirmed == true) {
        Get.offAll(
          () => const NavMenu(),
          duration: const Duration(milliseconds: 300),
          transition: Transition.fade,
        );
      } else {
        Get.offAll(
          () => const VerifySignUpEmail(
            email: '_auth.currentUser?.email',
          ),
          duration: const Duration(milliseconds: 300),
          transition: Transition.fade,
        );
      }
    } else {
      // User is not logged in, navigate to the login screen
      deviceStorage.writeIfNull('isFirstTime', true);
      deviceStorage.read('isFirstTime') != true
          ? Get.offAll(
              () => const LoginSignUpScreen(),
              duration: const Duration(milliseconds: 300),
              transition: Transition.fade,
            )
          : Get.offAll(
              () => const OnBoardingScreen(),
              duration: const Duration(milliseconds: 300),
              transition: Transition.fade,
            );
    }
  }

  Future<Map<String, dynamic>> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      final response = await Get.find<HttpService>().loginUser(email, password);
      final token = response['token'];
      deviceStorage.write('token', token);
      return response;
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }

  Future<void> registerWithEmailAndPassword(String firstName, String lastName,
      String username, String phoneNum, String email, String password) async {
    try {
      await HttpService.instance
          .signUpUser(firstName, lastName, username, phoneNum, email, password);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> sendEmailVerification(String email) async {
    try {
      await HttpService.instance.senEmailVerification(email);
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }

  Future<Map<String, dynamic>> checkIsConfirmed(String email) async {
    try {
      final response = await HttpService.instance.checkIsConfirmed(email);
      final isConfirmed = response['isConfirmed'];
      deviceStorage.write('isConfirmed', isConfirmed);
      return response;
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await HttpService.instance.sendPasswordResetEmail(email);
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }
}
