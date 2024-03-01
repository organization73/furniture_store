import 'dart:async';

import 'package:furniture_store/common/widgets/action_confirmation/action_confirmation_page.dart';
import 'package:furniture_store/common/widgets/loaders/loaders.dart';
import 'package:furniture_store/data/repositories/authentication/auth_test.dart';
import 'package:furniture_store/features/authentication/controllers/sign_up/sign_up_controller.dart';
import 'package:furniture_store/features/authentication/screens/gallery_selction/gallery_selection.dart';

import 'package:get/get.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  Timer? _timer; // Declare a Timer variable

  @override
  void onInit() {
    TLoaders.successSnackBar(
        title: 'changeYourEmailTitle'.tr,
        message: 'changeYourEmailSubTitle'.tr);
    setTimerForAutoRedirect();
    super.onInit();
  }

  @override
  void onClose() {
    // Cancel the timer when the controller is closed
    _timer?.cancel();
    super.onClose();
  }

  sendEmailVerification() async {
    try {
      await AuthenticatorRepoTest.instance.sendEmailVerification(
          SignUpController.instance.emailController.text);
      TLoaders.successSnackBar(
          title: 'changeYourEmailTitle'.tr,
          message: 'changeYourEmailSubTitle'.tr);
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!!', message: e.toString());
    }
  }

  setTimerForAutoRedirect() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      final currentUser = await AuthenticatorRepoTest.instance
          .checkIsConfirmed(SignUpController.instance.emailController.text);
      if (currentUser['isConfirmed'] ?? false) {
        timer.cancel();
        Get.off(
          () => ActionConfirmPage(
            subTitle: 'yourAccountCreatedSubTitle'.tr,
            title: 'yourAccountCreatedTitle'.tr,
            onPressed: () => Get.off(
              () =>  GallerySelection(),
              duration: const Duration(milliseconds: 300),
              transition: Transition.rightToLeft,
            ),
          ),
          duration: const Duration(milliseconds: 300),
          transition: Transition.rightToLeft,
        );
      }
    });
  }

  checkEmailVerificationStatus() async {
    final currentUser = await AuthenticatorRepoTest.instance
        .checkIsConfirmed(SignUpController.instance.emailController.text);
    if (currentUser['isConfirmed'] != null && currentUser['isConfirmed']) {
      Get.off(
        () => ActionConfirmPage(
          subTitle: 'yourAccountCreatedSubTitle'.tr,
          title: 'yourAccountCreatedTitle'.tr,
          onPressed: () => Get.off(
            () =>  GallerySelection(),
            duration: const Duration(milliseconds: 300),
            transition: Transition.rightToLeft,
          ),
        ),
        duration: const Duration(milliseconds: 300),
        transition: Transition.rightToLeft,
      );
    } else {
      TLoaders.warningSnackBar(
          title: 'Verify your email',
          message: 'Please check your email and verify your account');
    }
  }
}
