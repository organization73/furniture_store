import 'dart:async';

import 'package:furniture_store/common/widgets/action_confirmation/action_confirmation_page.dart';
import 'package:furniture_store/common/widgets/loaders/loaders.dart';
import 'package:furniture_store/data/repositories/authentication/auth_test.dart';
import 'package:furniture_store/features/authentication/controllers/sign_up/sign_up_controller.dart';
import 'package:furniture_store/features/authentication/screens/gallery_selection.dart';

import 'package:get/get.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  @override
  void onInit() {
    sendEmailVerification();
    setTimerForAutoRedirect();
    super.onInit();
  }

  sendEmailVerification() async {
    try {
      // await AuthenticatorRepoTest.instance.sendEmailVerification(
      //     SignUpController.instance.emailController.text);

      TLoaders.successSnackBar(
          title: 'changeYourEmailTitle'.tr,
          message: 'changeYourEmailSubTitle'.tr);
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!!', message: e.toString());
    }
  }

  setTimerForAutoRedirect() {
    Timer.periodic(const Duration(seconds: 5), (timer) async {
      // await FirebaseAuth.instance.currentUser?.reload();
      final currentUser = await AuthenticatorRepoTest.instance
          .checkIsConfirmed(SignUpController.instance.emailController.text);
      // final user = FirebaseAuth.instance.currentUser;
      if (currentUser['isConfirmed'] ?? false) {
        timer.cancel();
        Get.off(
          () => ActionConfirmPage(
            subTitle: 'yourAccountCreatedSubTitle'.tr,
            title: 'yourAccountCreatedTitle'.tr,
            onPressed: () => Get.off(
              () => const GallerySelection(),
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
            () => const GallerySelection(),
            duration: const Duration(milliseconds: 300),
            transition: Transition.rightToLeft,
          ),
        ),
        duration: const Duration(milliseconds: 300),
        transition: Transition.rightToLeft,
      );
    }
  }
}
