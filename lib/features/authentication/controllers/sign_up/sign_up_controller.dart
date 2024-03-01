import 'package:flutter/material.dart';
import 'package:furniture_store/common/widgets/loaders/loaders.dart';
import 'package:furniture_store/data/repositories/authentication/auth_test.dart';
import 'package:furniture_store/data/repositories/user/user_repo.dart';
import 'package:furniture_store/features/authentication/screens/sign_up/verify_sign_up_email.dart';
import 'package:furniture_store/features/personalization/models/user_model.dart';

import 'package:furniture_store/utils/helpers/network_manager.dart';
import 'package:furniture_store/utils/popups/full_screen_loader.dart';
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
          'We are processing your information...',
          'assets/animations/animation-of-docer.json');

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        TLoaders.warningSnackBar(
            title: 'No Internet', message: 'No internet connection!');
        return;
      }

      if (!formKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();

        return;
      }

      if (!privacyPolicy.value) {
        FullScreenLoader.stopLoading();

        TLoaders.warningSnackBar(
            title: 'Accept Privacy Policy',
            message:
                'In order to create an account you must accept the privacy policy and terms of use.');

        return;
      }

      await AuthenticatorRepoTest.instance.registerWithEmailAndPassword(
        firstNameController.text,
        lastNameController.text,
        userNameController.text,
        phoneNumController.text,
        emailController.text,
        passwordController.text,
      );

      final newUser = UserModel(
          id: ' userCred.user!.uid',
          firstName: firstNameController.text.trim(),
          lastName: lastNameController.text.trim(),
          userName: userNameController.text.trim(),
          email: emailController.text.trim(),
          phoneNumber: phoneNumController.text.trim(),
          avatar: '');

      final userRepesotory = Get.put(UserRepo());
      await userRepesotory.saveUserRecord(newUser);

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

      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
