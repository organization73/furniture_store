import 'package:decordash/data/repositories/authentication/authentication_repo.dart';
import 'package:decordash/utils/helpers/network_manager.dart';
import 'package:flutter/material.dart';
import 'package:decordash/common/widgets/loaders/loaders.dart';
import 'package:decordash/features/authentication/screens/sign_in_with_phone/enter_code.dart';
import 'package:decordash/utils/popups/full_screen_loader.dart';
import 'package:get/get.dart';

class PhoneSingInController extends GetxController {
  static PhoneSingInController get instance => Get.find();

  final GlobalKey<FormState> phoneFormKey = GlobalKey<FormState>();
  final TextEditingController phoneNumController = TextEditingController();

  Future<void> phonedSignIn() async {
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

      if (!phoneFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      await AuthenticatorRepo.instance
          .loginWithPhone(phoneNumController.text.trim());

      // await userController.saveUserRecord(userCred);
      FullScreenLoader.stopLoading();

      // AuthenticatorRepo.instance.screenRedirect();
      Get.to(
        () => CodeVerificationScreen(
          phoneNumber: phoneNumController.text,
        ),
        duration: const Duration(milliseconds: 300),
        transition: Transition.rightToLeft,
      );
    } catch (e) {
      FullScreenLoader.stopLoading();

      TLoaders.errorSnackBar(title: 'ohSnap'.tr, message: e.toString());
    }
  }
}
