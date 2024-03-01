import 'package:flutter/material.dart';
import 'package:furniture_store/common/widgets/loaders/loaders.dart';
import 'package:furniture_store/data/repositories/authentication/auth_test.dart';
import 'package:furniture_store/features/authentication/screens/reset_password/reset_password_screen.dart';
import 'package:furniture_store/utils/helpers/network_manager.dart';
import 'package:furniture_store/utils/popups/full_screen_loader.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  final GlobalKey<FormState> forgotPassFormKey = GlobalKey<FormState>();

  // TextEditingController for each input field
  final TextEditingController emailController = TextEditingController();

  sendPasswordResetEmail() async {
    try {
      FullScreenLoader.openLoadingDialog('Processing your request...',
          'assets/animations/animation-of-docer.json');
      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        FullScreenLoader.stopLoading();
        TLoaders.warningSnackBar(
            title: 'No Internet', message: 'No internet connection!');
        return;
      }

      if (!forgotPassFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();

        return;
      }

      await AuthenticatorRepoTest.instance
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
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  resendPasswordResetEmail(String email) async {
    try {
      FullScreenLoader.openLoadingDialog('Processing your request...',
          'assets/animations/animation-of-docer.json');
      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        FullScreenLoader.stopLoading();
        TLoaders.warningSnackBar(
            title: 'No Internet', message: 'No internet connection!');
        return;
      }

      // await AuthenticatorRepo.instance.sendPasswordResetEmail(email);

      FullScreenLoader.stopLoading();
      TLoaders.successSnackBar(
          title: 'Email Sent',
          message: 'Email link has been sent to reset your password');
    } catch (e) {
      FullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
