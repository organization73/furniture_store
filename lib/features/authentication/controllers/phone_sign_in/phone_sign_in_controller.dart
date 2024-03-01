import 'package:flutter/material.dart';
import 'package:furniture_store/common/widgets/loaders/loaders.dart';
import 'package:furniture_store/features/authentication/screens/sign_in_with_phone/enter_code.dart';
import 'package:furniture_store/utils/popups/full_screen_loader.dart';
import 'package:get/get.dart';

class PhoneSingInController extends GetxController {
  static PhoneSingInController get instance => Get.find();

  final GlobalKey<FormState> phoneFormKey = GlobalKey<FormState>();
  // TextEditingController for each input field
  final TextEditingController phoneNumController = TextEditingController();

  Future<void> phonedSignIn() async {
    try {
      // FullScreenLoader.openLoadingDialog(
      //     'Logging you in...', 'assets/animations/animation-of-docer.json');

      // final isConnected = await NetworkManager.instance.isConnected();

      // if (!isConnected) {
      //   FullScreenLoader.stopLoading();
      //   TLoaders.warningSnackBar(
      //       title: 'No Internet', message: 'No internet connection!');
      //   return;
      // }

      if (!phoneFormKey.currentState!.validate()) {
        // FullScreenLoader.stopLoading();

        return;
      }
      Get.to(
        () => CodeVerificationScreen(
          phoneNumber: phoneNumController.text,
        ),
        duration: const Duration(milliseconds: 300),
        transition: Transition.rightToLeft,
      );
    } catch (e) {
      FullScreenLoader.stopLoading();

      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
