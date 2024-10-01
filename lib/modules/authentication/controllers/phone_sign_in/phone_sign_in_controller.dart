import 'package:decordashapp/data/repositories/authentication/authentication_repo.dart';
import 'package:decordashapp/modules/authentication/screens/phone_login/enter_code.dart';
import 'package:decordashapp/utils/helpers/network_manager.dart';
import 'package:decordashapp/common/widgets/loaders/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class PhoneSingInController extends GetxController {
  static PhoneSingInController get instance => Get.find();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  PhoneNumber number = PhoneNumber(isoCode: 'EG');

  void loginWithPhone() async {
    try {
      final isConnected = NetworkManager.instance.isConnected();

      if (!isConnected) {
        TLoaders.warningSnackBar(
            title: 'internet'.tr, message: 'noInternet'.tr);
        return;
      }

      if (!formKey.currentState!.validate()) {
        return;
      }

      await AuthenticatorRepo.instance.loginWithPhone(number.phoneNumber!);

      Get.to(
        () => CodeVerificationScreen(phoneNumber: number.phoneNumber!),
        duration: const Duration(milliseconds: 300),
        transition: Transition.rightToLeft,
      );
    } catch (e) {
      TLoaders.errorSnackBar(title: 'ohSnap'.tr, message: e.toString());
    }
  }
}
