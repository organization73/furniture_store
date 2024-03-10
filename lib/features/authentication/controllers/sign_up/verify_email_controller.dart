import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:decordash/common/widgets/action_confirmation/action_confirmation_page.dart';
import 'package:decordash/common/widgets/loaders/loaders.dart';
import 'package:decordash/data/repositories/authentication/authentication_repo.dart';
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
      await AuthenticatorRepo.instance.sendEmailVerification();
      TLoaders.successSnackBar(
          title: 'changeYourEmailTitle'.tr,
          message: 'changeYourEmailSubTitle'.tr);
    } catch (e) {
      TLoaders.errorSnackBar(title: 'ohSnap'.tr, message: e.toString());
    }
  }

  setTimerForAutoRedirect() {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user?.emailVerified ?? false) {
        timer.cancel();
        Get.off(
          () => ActionConfirmPage(
            subTitle: 'yourAccountCreatedSubTitle'.tr,
            title: 'yourAccountCreatedTitle'.tr,
            onPressed: () => AuthenticatorRepo.instance.screenRedirect(),
          ),
          duration: const Duration(milliseconds: 300),
          transition: Transition.rightToLeft,
        );
      }
    });
  }

  checkEmailVerificationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      Get.off(
        () => ActionConfirmPage(
          subTitle: 'yourAccountCreatedSubTitle'.tr,
          title: 'yourAccountCreatedTitle'.tr,
          onPressed: () => AuthenticatorRepo.instance.screenRedirect(),
        ),
        duration: const Duration(milliseconds: 300),
        transition: Transition.rightToLeft,
      );
    }
  }
}
