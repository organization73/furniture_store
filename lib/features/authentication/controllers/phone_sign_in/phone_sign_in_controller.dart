import 'package:decordash/data/repositories/authentication/authentication_repo.dart';
import 'package:decordash/utils/helpers/network_manager.dart';
import 'package:decordash/common/widgets/loaders/loaders.dart';
import 'package:decordash/utils/logging/logger.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhoneSingInController extends GetxController {
  static PhoneSingInController get instance => Get.find();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  RxString phoneNumber = ''.obs;

  void loginWithPhone() async {
    try {
      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        TLoaders.warningSnackBar(
            title: 'internet'.tr, message: 'noInternet'.tr);
        return;
      }

      if (!formKey.currentState!.validate()) {
        return;
      }

      await AuthenticatorRepo.instance.loginWithPhone(phoneNumber.value);
    } catch (e) {
      LoggerHelper.error(e.toString());
      TLoaders.errorSnackBar(title: 'ohSnap'.tr, message: e.toString());
    }
  }
}
