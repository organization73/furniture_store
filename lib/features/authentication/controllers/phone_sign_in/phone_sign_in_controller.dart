import 'package:decordashapp/data/repositories/authentication/authentication_repo.dart';
import 'package:decordashapp/data/repositories/user/user_repo.dart';
import 'package:decordashapp/data/services/notification_service.dart';
import 'package:decordashapp/utils/helpers/network_manager.dart';
import 'package:decordashapp/common/widgets/loaders/loaders.dart';
import 'package:decordashapp/utils/logging/logger.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhoneSingInController extends GetxController {
  static PhoneSingInController get instance => Get.find();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  static final notifications = NotificationsService();

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

      await AuthenticatorRepo.instance.loginWithPhone(phoneNumber.text);
      await UserRepo.instance.updateSingleField(
        {'lastActive': DateTime.now()},
      );
      await notifications.requestPermission();
      await notifications.getToken();
    } catch (e) {
      LoggerHelper.error(e.toString());
      TLoaders.errorSnackBar(title: 'ohSnap'.tr, message: e.toString());
    }
  }
}
