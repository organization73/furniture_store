import 'package:decordashapp/data/repositories/user/user_repo.dart';
import 'package:decordashapp/data/services/chat/notifications/notification_service.dart';
import 'package:decordashapp/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:decordashapp/common/widgets/loaders/loaders.dart';
import 'package:decordashapp/data/repositories/authentication/authentication_repo.dart';
import 'package:decordashapp/modules/authentication/screens/signup/verify_signup_email.dart';
import 'package:decordashapp/modules/profile/models/user_model.dart';
import 'package:decordashapp/utils/helpers/network_manager.dart';
import 'package:decordashapp/utils/popups/full_screen_loader.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final hidePassword = true.obs;
  final privacyPolicy = false.obs;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final FocusNode firstNameFocus = FocusNode();
  final FocusNode lastNameFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final FocusNode phoneNumberFocus = FocusNode();
  PhoneNumber number = PhoneNumber(isoCode: 'EG');

  static final notifications = NotificationsService();

  void signup() async {
    try {
      FullScreenLoader.openLoadingDialog(
          'processingLoading'.tr, ImageStrings.processingInfo);

      final isConnected = NetworkManager.instance.isOnline;
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
        phoneNumber: number.phoneNumber!,
      );

      await UserRepo.instance.saveuserRecord(newUser);

      await notifications.requestPermission();
      await notifications.getToken();

      FullScreenLoader.stopLoading();

      Get.to(
        () => VerifySignUpEmail(email: emailController.text.trim()),
      );
    } catch (e) {
      FullScreenLoader.stopLoading();

      TLoaders.errorSnackBar(title: 'ohSnap'.tr, message: e.toString());
    }
  }
}
