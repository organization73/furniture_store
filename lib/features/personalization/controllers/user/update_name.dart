import 'package:decordash/utils/http/http_client.dart';
import 'package:flutter/material.dart';
import 'package:decordash/common/widgets/loaders/loaders.dart';
import 'package:decordash/data/repositories/user/user_repo.dart';
import 'package:decordash/features/personalization/controllers/user/user_controller.dart';
import 'package:decordash/features/personalization/screens/profile/profile.dart';
import 'package:decordash/utils/helpers/network_manager.dart';
import 'package:decordash/utils/popups/full_screen_loader.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();

  final GlobalKey<FormState> updateNameFormKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

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
    emailController.text = userController.user.value.email;
    usernameController.text = userController.user.value.username ?? "";
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

      try {
        await THttpHelper.putBearerAuth(
            "user/update-user-info", GetStorage().read("token"), {
          "username": usernameController.text.trim(),
          "firstName": firstNameController.text.trim(),
          "lastName": lastNameController.text.trim(),
        });
      } catch (e) {
        FullScreenLoader.stopLoading();
        TLoaders.errorSnackBar(title: 'ohSnap'.tr, message: e.toString());
        return;
      }

// {
//     "username":"abdo.body123",
//     "firstName":"abdo",
//     "lastName":"body",
//     "phone":"12345678912"
// }
      userController.user.value.firstName = firstNameController.text.trim();
      userController.user.value.lastName = lastNameController.text.trim();
      userController.user.value.username = usernameController.text.trim();

      userController.user.refresh();

      FullScreenLoader.stopLoading();

      TLoaders.successSnackBar(
          title: 'Done', message: 'Your info has been updated');

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
