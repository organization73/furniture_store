import 'package:decordash/data/repositories/authentication/authentication_repo.dart';
import 'package:decordash/utils/helpers/network_manager.dart';
import 'package:decordash/common/widgets/loaders/loaders.dart';
import 'package:decordash/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhoneSingInController extends GetxController {
  static PhoneSingInController get instance => Get.find();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final hidePassword = true.obs;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();

  final TextEditingController phoneNumController = TextEditingController();

  void loginWithPhone() async {
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
      formKey.currentState?.save();

      await AuthenticatorRepo.instance
          .loginWithPhone(phoneNumController.text.trim());

      FullScreenLoader.stopLoading();
    } catch (e) {
      FullScreenLoader.stopLoading();

      TLoaders.errorSnackBar(title: 'ohSnap'.tr, message: e.toString());
    }
  }
}
