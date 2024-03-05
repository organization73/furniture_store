import 'package:flutter/material.dart';
import 'package:furniture_store/common/widgets/loaders/loaders.dart';
import 'package:furniture_store/data/repositories/user/user_repo.dart';
import 'package:furniture_store/features/personalization/controllers/user/user_controller.dart';
import 'package:furniture_store/utils/helpers/network_manager.dart';
import 'package:furniture_store/utils/popups/full_screen_loader.dart';
import 'package:get/get.dart';

class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();

  final GlobalKey<FormState> updateNameFormKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  final userController = UserController.instance;
  final userRepository = Get.put(UserRepo());

  @override
  void onInit() {
    initializeNames();
    super.onInit();
  }

  Future<void> initializeNames() async {
    firstNameController.text = userController.user.value.firstName;
    lastNameController.text = userController.user.value.lastName;
  }

  Future<void> updateUserName() async {
    try {
      FullScreenLoader.openLoadingDialog(
          'updatingInfo'.tr, 'assets/animations/animation-of-docer.json');

      final isConnected = await NetworkManager.instance.isConnected();

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

      FullScreenLoader.stopLoading();

      TLoaders.successSnackBar(
          title: 'Done', message: 'Your name has been updated');

      // Get.off(
      //   () => const ProfileScreen(),
      //   duration: const Duration(milliseconds: 300),
      //   transition: Transition.downToUp,
      // );
    } catch (e) {
      FullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'ohSnap'.tr, message: e.toString());
    }
  }
}
