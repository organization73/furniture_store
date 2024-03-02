import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:furniture_store/data/repositories/authentication/api_services.dart';
import 'package:furniture_store/data/repositories/user/user_repo.dart';
import 'package:furniture_store/features/authentication/screens/login/login_screen.dart';
import 'package:furniture_store/features/authentication/screens/sign_up/verify_sign_up_email.dart';
import 'package:furniture_store/features/home/screens/nav_menu.dart';
import 'package:furniture_store/features/onboarding/screens/onboarding_screen.dart';
import 'package:furniture_store/features/personalization/controllers/user/user_controller.dart';
import 'package:furniture_store/features/personalization/models/user_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthenticatorRepoTest extends GetxController {
  static AuthenticatorRepoTest get instance => Get.find();

  final deviceStorage = GetStorage();
  final UserController userController = Get.find<UserController>();

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

    final user = userController.user;
    if (user != null) {
      print("User ID: ${user.email}");
      // Access other user properties as needed
    } else {
      print("No user data found in storage.");
    }

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
          () => VerifySignUpEmail(
            email: user!.email,
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
      print(email);
      print(password);
      final response = await HttpService.instance.loginUser(email, password);
      final token = response['token'];
      deviceStorage.write('token', token);
      deviceStorage.write('isConfirmed', true);
      return response;
    } catch (e) {
      rethrow;
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
  }

  void updateUserVerificationStatus(bool value) {
    final userController = Get.find<UserController>();
    final user = userController.user;

    if (user != null) {
      // Create a new UserModel instance with the verified field set to true
      final updatedUser = user.copyWith(verified: value);

      // Update the user data in the UserController and save it to local storage
      userController.updateUser(updatedUser);
    } else {
      print("No user data found.");
    }
  }

  Future<Map<String, dynamic>> checkIsConfirmed(String email) async {
    try {
      final response = await HttpService.instance.checkIsConfirmed(email);
      final isConfirmed = response['isConfirmed'];
      // updateUserVerificationStatus(isConfirmed);
      deviceStorage.write('isConfirmed', isConfirmed);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await HttpService.instance.sendPasswordResetEmail(email);
    } catch (e) {
      rethrow;
    }
  }
}
