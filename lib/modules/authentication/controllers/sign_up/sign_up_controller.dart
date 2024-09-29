import 'package:decordashapp/data/services/chat/notifications/notification_service.dart';
import 'package:decordashapp/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:decordashapp/common/widgets/loaders/loaders.dart';
import 'package:decordashapp/data/repositories/authentication/authentication_repo.dart';
import 'package:decordashapp/data/repositories/user/user_repo.dart';
import 'package:decordashapp/modules/authentication/screens/sign_up/verify_sign_up_email.dart';
import 'package:decordashapp/modules/personalization/models/user_model.dart';
import 'package:decordashapp/utils/helpers/network_manager.dart';
import 'package:decordashapp/utils/popups/full_screen_loader.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final hidePassword = true.obs;
  final privacyPolicy = false.obs;

  // TextEditingController for each input field
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  RxString phoneNumController = ''.obs;

  static final notifications = NotificationsService();

  void signup() async {
    try {
      FullScreenLoader.openLoadingDialog(
          'processingLoading'.tr, TImages.processingInfo);

      final isConnected = NetworkManager.instance.isConnected();
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
        email: emailController.text.trim(),
        phoneNumber: phoneNumController.value.trim(),
      );

      final userRepesotory = Get.put(UserRepo());
      await userRepesotory.saveuserRecord(newUser);

      await notifications.requestPermission();
      await notifications.getToken();

      FullScreenLoader.stopLoading();

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
