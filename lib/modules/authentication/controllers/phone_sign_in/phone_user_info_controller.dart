import 'package:decordashapp/common/widgets/loaders/loaders.dart';
import 'package:decordashapp/data/repositories/user/user_repo.dart';
import 'package:decordashapp/modules/authentication/screens/gallery_selction/gallery_selection.dart';
import 'package:decordashapp/modules/profile/controllers/user_controller.dart';
import 'package:decordashapp/modules/profile/models/user_model.dart';
import 'package:decordashapp/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhoneUserInfoController extends GetxController {
  static PhoneUserInfoController get instance => Get.find();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  final userController = UserController.instance;
  final userRepository = UserRepo.instance;

  void updateInfo() async {
    try {
      FullScreenLoader.openSmallLoadingDialog('updatingInfo'.tr);

      if (!formKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();

        return;
      }
      final String userName = UserModel.generateUsernameFromFullName(
          '${firstNameController.text.trim()} ${lastNameController.text.trim()}');
      Map<String, dynamic> name = {
        'firstName': firstNameController.text.trim(),
        'lastName': lastNameController.text.trim(),
        'userName': userName,
      };
      await userRepository.updateSingleField(name);

      userController.user.value.firstName = firstNameController.text.trim();
      userController.user.value.lastName = lastNameController.text.trim();

      userController.user.refresh();

      FullScreenLoader.stopLoading();

      TLoaders.successSnackBar(
          title: 'Done', message: 'Your name has been updated');

      FullScreenLoader.stopLoading();

      Get.to(
        () => GallerySelection(),
        duration: const Duration(milliseconds: 300),
        transition: Transition.rightToLeft,
      );
    } catch (e) {
      FullScreenLoader.stopLoading();

      TLoaders.errorSnackBar(title: 'ohSnap'.tr, message: e.toString());
    }
  }
}
