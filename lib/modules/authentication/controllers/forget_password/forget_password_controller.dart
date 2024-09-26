import 'package:decordashapp/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:decordashapp/common/widgets/loaders/loaders.dart';
import 'package:decordashapp/data/repositories/authentication/authentication_repo.dart';
import 'package:decordashapp/modules/authentication/screens/reset_password/reset_password_screen.dart';
import 'package:decordashapp/utils/helpers/network_manager.dart';
import 'package:decordashapp/utils/popups/full_screen_loader.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  final GlobalKey<FormState> forgotPassFormKey = GlobalKey<FormState>();

  // TextEditingController for each input field
  final TextEditingController emailController = TextEditingController();

  sendPasswordResetEmail() async {
    try {
      FullScreenLoader.openLoadingDialog(
          'Processing your request...', TImages.processingInfo);
      final isConnected = NetworkManager.instance.isConnected();

      if (!isConnected) {
        FullScreenLoader.stopLoading();
        TLoaders.warningSnackBar(
            title: 'internet'.tr, message: 'noInternet'.tr);
        return;
      }

      if (!forgotPassFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();

        return;
      }

      await AuthenticatorRepo.instance
          .sendPasswordResetEmail(emailController.text.trim());

      FullScreenLoader.stopLoading();
      TLoaders.successSnackBar(
          title: 'Email Sent',
          message: 'Email link has been sent to reset your password');

      Get.to(
        () => ResetPasswordScreen(
          email: emailController.text.trim(),
        ),
        duration: const Duration(milliseconds: 300),
        transition: Transition.downToUp,
      );
    } catch (e) {
      FullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'ohSnap'.tr, message: e.toString());
    }
  }

  resendPasswordResetEmail(String email) async {
    try {
      FullScreenLoader.openLoadingDialog(
          'Processing your request...', TImages.processingInfo);
      final isConnected = NetworkManager.instance.isConnected();

      if (!isConnected) {
        FullScreenLoader.stopLoading();
        TLoaders.warningSnackBar(
            title: 'internet'.tr, message: 'noInternet'.tr);
        return;
      }

      await AuthenticatorRepo.instance.sendPasswordResetEmail(email);

      FullScreenLoader.stopLoading();
      TLoaders.successSnackBar(
          title: 'Email Sent',
          message: 'Email link has been sent to reset your password');
    } catch (e) {
      FullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'ohSnap'.tr, message: e.toString());
    }
  }
}
