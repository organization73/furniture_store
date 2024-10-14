import 'package:decordashapp/data/services/chat/notifications/notification_service.dart';
import 'package:decordashapp/modules/authentication/screens/gallery_selction/gallery_selection.dart';
import 'package:decordashapp/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:decordashapp/common/widgets/loaders/loaders.dart';
import 'package:decordashapp/data/repositories/authentication/authentication_repo.dart';
import 'package:decordashapp/modules/profile/controllers/user_controller.dart';
import 'package:decordashapp/utils/helpers/network_manager.dart';
import 'package:decordashapp/utils/popups/full_screen_loader.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final localStorage = GetStorage();
  final hidePassword = true.obs;

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  static final notifications = NotificationsService();

  Future<void> emailAndPasswordSignIn() async {
    try {
      FullScreenLoader.openLoadingDialog(
          'loggingInLoadingTitle'.tr, TImages.processingInfo);

      final isConnected = NetworkManager.instance.isConnected();

      if (!isConnected) {
        FullScreenLoader.stopLoading();
        TLoaders.warningSnackBar(
            title: 'internet'.tr, message: 'noInternet'.tr);
        return;
      }

      if (!loginFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();

        return;
      }

      await AuthenticatorRepo.instance.loginWithEmailAndPassword(
          emailController.text.trim(), passwordController.text.trim());

      await notifications.requestPermission();
      await notifications.getToken();
      FullScreenLoader.stopLoading();

      AuthenticatorRepo.instance.screenRedirect();
    } catch (e) {
      FullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'ohSnap'.tr, message: e.toString());
    }
  }

  Future<void> googleSignIn() async {
    try {
      FullScreenLoader.openLoadingDialog(
          'loggingInLoadingTitle'.tr, TImages.processingInfo);

      final isConnected = NetworkManager.instance.isConnected();

      if (!isConnected) {
        FullScreenLoader.stopLoading();
        TLoaders.warningSnackBar(
            title: 'internet'.tr, message: 'noInternet'.tr);
        return;
      }

      final userCred = await AuthenticatorRepo.instance.signInWithGoogle();

      await UserController.instance.saveUserRecord(userCred);

      await notifications.requestPermission();
      await notifications.getToken();
      FullScreenLoader.stopLoading();

      Get.to(
        () => GallerySelection(),
        duration: const Duration(milliseconds: 300),
        transition: Transition.rightToLeft,
      );
    } catch (e) {
      FullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'ohSnap'.tr, message: e.toString());
    }
  }
}
