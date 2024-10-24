import 'package:decordashapp/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:decordashapp/common/widgets/loaders/loaders.dart';
import 'package:decordashapp/data/repositories/user/user_repo.dart';
import 'package:decordashapp/modules/profile/controllers/user_controller.dart';
import 'package:decordashapp/modules/profile/screens/profile_screen.dart';
import 'package:decordashapp/utils/helpers/network_manager.dart';
import 'package:decordashapp/utils/popups/full_screen_loader.dart';
import 'package:get/get.dart';

class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();

  final GlobalKey<FormState> updateNameFormKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  final userController = UserController.instance;
  final userRepository = UserRepo.instance;

  @override
  void onInit() {
    super.onInit();

    initializeNames();
  }

  Future<void> initializeNames() async {
    firstNameController.text = userController.user.value.firstName;
    lastNameController.text = userController.user.value.lastName;
  }

  Future<void> updateUserName() async {
    try {
      FullScreenLoader.openLoadingDialog(
          'updatingInfo'.tr, ImageStrings.processingInfo);

      final isConnected = NetworkManager.instance.isOnline.value;

      if (!isConnected) {
        FullScreenLoader.stopLoading();
        TLoaders.warningSnackBar(
            title: 'internet'.tr, message: 'noInternet'.tr);
        return;
      }

      if (!updateNameFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();

        return;
      }

      Map<String, dynamic> name = {
        'firstName': firstNameController.text.trim(),
        'lastName': lastNameController.text.trim()
      };
      await userRepository.updateSingleField(name);

      userController.user.value.firstName = firstNameController.text.trim();
      userController.user.value.lastName = lastNameController.text.trim();

      userController.user.refresh();

      FullScreenLoader.stopLoading();

      TLoaders.successSnackBar(
          title: 'Done', message: 'Your name has been updated');

      Get.off(
        () => const ProfileScreen(),
        duration: const Duration(milliseconds: 300),
        transition: Transition.downToUp,
      );
    } catch (e) {
      FullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'ohSnap'.tr, message: e.toString());
    }
  }
}
