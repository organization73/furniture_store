import 'package:flutter/material.dart';
import 'package:furniture_store/common/widgets/loaders/loaders.dart';
import 'package:furniture_store/data/repositories/authentication/auth_test.dart';
import 'package:furniture_store/data/repositories/user/user_repo.dart';
import 'package:furniture_store/features/personalization/controllers/user/user_controller.dart';
import 'package:furniture_store/features/personalization/models/user_model.dart';
import 'package:furniture_store/utils/helpers/network_manager.dart';
import 'package:furniture_store/utils/popups/full_screen_loader.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();
  final localStorage = GetStorage();
  final hidePassword = true.obs;
  final rememberMe = false.obs;
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  // TextEditingController for each input field
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void onInit() {
    emailController.text = localStorage.read('REMEMBER_ME_MAIL') ?? '';
    passwordController.text = localStorage.read('REMEMBER_ME_PASSWORD') ?? '';

    super.onInit();
  }

  Future<void> emailAndPasswordSignIn() async {
    try {
      FullScreenLoader.openLoadingDialog(
          'Logging you in...', 'assets/animations/animation-of-docer.json');

      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        FullScreenLoader.stopLoading();
        TLoaders.warningSnackBar(
            title: 'No Internet', message: 'No internet connection!');
        return;
      }

      if (!loginFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();

        return;
      }

      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_MAIL', emailController.text.trim());
        localStorage.write(
            'REMEMBER_ME_PASSWORD', passwordController.text.trim());
      }

      await AuthenticatorRepoTest.instance.loginWithEmailAndPassword(
          emailController.text.trim(), passwordController.text.trim());

      final newUser = UserModel(
        id: ' 0',
        email: emailController.text.trim(),
      );

      final userController = Get.find<UserController>();
      userController.saveUserData(newUser);

      FullScreenLoader.stopLoading();

      AuthenticatorRepoTest.instance.screenRedirect();
    } catch (e) {
      FullScreenLoader.stopLoading();

      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  Future<void> googleSignIn() async {
    try {
      FullScreenLoader.openLoadingDialog(
          'Logging you in...', 'assets/animations/animation-of-docer.json');

      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        FullScreenLoader.stopLoading();
        TLoaders.warningSnackBar(
            title: 'No Internet', message: 'No internet connection!');
        return;
      }

      // final userCred = await AuthenticatorRepo.instance.signInWithGoogle();

      // await userController.saveUserRecord(userCred);
      // FullScreenLoader.stopLoading();

      // AuthenticatorRepo.instance.screenRedirect();
    } catch (e) {
      FullScreenLoader.stopLoading();

      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
