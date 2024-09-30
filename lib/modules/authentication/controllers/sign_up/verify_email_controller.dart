import 'dart:async';
import 'package:decordashapp/modules/authentication/screens/gallery_selction/gallery_selection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:decordashapp/common/widgets/loaders/loaders.dart';
import 'package:decordashapp/data/repositories/authentication/authentication_repo.dart';
import 'package:get/get.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  RxBool isEmailVerified = false.obs;

  @override
  void onInit() {
    super.onInit();
    sendEmailVerification();
    setTimerForAutoRedirect();
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
        isEmailVerified.value = true;
      }
    });
  }

  checkEmailVerificationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      Get.off(
        () => GallerySelection(),
        duration: const Duration(milliseconds: 300),
        transition: Transition.rightToLeft,
      );

      TLoaders.successSnackBar(
          title: 'congrats'.tr, message: 'accountCreationConfirmed'.tr);
    }
  }
}
