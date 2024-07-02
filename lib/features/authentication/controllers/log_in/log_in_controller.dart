import 'dart:convert';

import 'package:decordash/data/repositories/user/user_repo.dart';
import 'package:decordash/data/services/notification_service.dart';
import 'package:decordash/features/personalization/models/user_model.dart';
import 'package:decordash/utils/logging/logger.dart';
import 'package:flutter/material.dart';
import 'package:decordash/common/widgets/loaders/loaders.dart';
import 'package:decordash/data/repositories/authentication/authentication_repo.dart';
import 'package:decordash/features/personalization/controllers/user/user_controller.dart';
import 'package:decordash/utils/helpers/network_manager.dart';
import 'package:decordash/utils/popups/full_screen_loader.dart';
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
  final userController = Get.put(UserController());
  static final notifications = NotificationsService();

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

      final response = await AuthenticatorRepo.instance
          .loginWithEmailAndPassword(
              emailController.text.trim(), passwordController.text.trim());
      final userController = Get.find<UserController>();
      print("response: $response['user']");
      userController.saveUserData(response);
      UserModel user = UserModel.fromJson(response['user']);
      UserController.instance.user.value = user;
      FullScreenLoader.stopLoading();

      AuthenticatorRepo.instance.screenRedirect();
    } catch (e) {
      FullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      print(e.toString());
    }
  }

  Future<void> googleSignIn() async {
    try {
      FullScreenLoader.openLoadingDialog('loggingInLoadingTitle'.tr,
          'assets/animations/animation-of-docer.json');

      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        FullScreenLoader.stopLoading();
        TLoaders.warningSnackBar(
            title: 'internet'.tr, message: 'noInternet'.tr);
        return;
      }

      final userCred = await AuthenticatorRepo.instance.signInWithGoogle();

      await userController.saveUserRecord(userCred);
      await UserRepo.instance.updateSingleField(
        {'lastActive': DateTime.now()},
      );

      await notifications.requestPermission();
      await notifications.getToken();
      FullScreenLoader.stopLoading();

      AuthenticatorRepo.instance.screenRedirect();
    } catch (e) {
      FullScreenLoader.stopLoading();
      LoggerHelper.error(e.toString());
      TLoaders.errorSnackBar(title: 'ohSnap'.tr, message: e.toString());
    }
  }
}
