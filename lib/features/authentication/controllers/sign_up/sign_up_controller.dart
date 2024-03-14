import 'package:flutter/material.dart';
import 'package:decordash/common/widgets/loaders/loaders.dart';
import 'package:decordash/data/repositories/authentication/authentication_repo.dart';
import 'package:decordash/data/repositories/user/user_repo.dart';
import 'package:decordash/features/authentication/screens/sign_up/verify_sign_up_email.dart';
import 'package:decordash/features/personalization/models/user_model.dart';
import 'package:decordash/utils/helpers/network_manager.dart';
import 'package:decordash/utils/popups/full_screen_loader.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final hidePassword = true.obs;
  final privacyPolicy = false.obs;

  // TextEditingController for each input field
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneNumController = TextEditingController();

  void signup() async {
    try {
      FullScreenLoader.openLoadingDialog(
          'processingLoading'.tr, 'assets/animations/animation-of-docer.json');

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        TLoaders.warningSnackBar(
            title: 'internet'.tr, message: 'noInternet'.tr);
        return;
      }

      if (!formKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();

        return;
      }

      if (!privacyPolicy.value) {
        FullScreenLoader.stopLoading();

        TLoaders.warningSnackBar(
            title: 'policyAndTerms'.tr, message: 'policyAndTermsDesc'.tr);

        return;
      }

      final userCred = await AuthenticatorRepo.instance
          .registerWithEmailAndPassword(
              emailController.text.trim(), passwordController.text.trim());

      final newUser = UserModel(
          id: userCred.user!.uid,
          firstName: firstNameController.text.trim(),
          lastName: lastNameController.text.trim(),
          userName: userNameController.text.trim(),
          email: emailController.text.trim(),
          phoneNumber: phoneNumController.text.trim(),
         );

      final userRepesotory = Get.put(UserRepo());
      await userRepesotory.saveuserRecord(newUser);

      FullScreenLoader.stopLoading();

      TLoaders.successSnackBar(
          title: 'congrats'.tr, message: 'accountCreationConfirmed'.tr);
      Get.to(
        () => VerifySignUpEmail(email: emailController.text.trim()),
        duration: const Duration(milliseconds: 300),
        transition: Transition.rightToLeft,
      );
    } catch (e) {
      FullScreenLoader.stopLoading();

      TLoaders.errorSnackBar(title: 'ohSnap'.tr, message: e.toString());
    }
  }
}
