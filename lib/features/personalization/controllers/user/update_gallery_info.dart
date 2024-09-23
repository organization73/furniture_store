import 'package:decordashapp/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:decordashapp/common/widgets/loaders/loaders.dart';
import 'package:decordashapp/data/repositories/user/user_repo.dart';
import 'package:decordashapp/features/personalization/controllers/user/user_controller.dart';
import 'package:decordashapp/features/personalization/screens/profile/profile.dart';
import 'package:decordashapp/utils/helpers/network_manager.dart';
import 'package:decordashapp/utils/popups/full_screen_loader.dart';
import 'package:get/get.dart';

class UpdateGalleryController extends GetxController {
  static UpdateGalleryController get instance => Get.find();

  final GlobalKey<FormState> updateGalleryFormKey = GlobalKey<FormState>();
  final TextEditingController galleryNameController = TextEditingController();

  final userController = UserController.instance;
  final userRepository = Get.put(UserRepo());

  @override
  void onInit() {
    super.onInit();
    initializeValues();
  }

  Future<void> initializeValues() async {
    galleryNameController.text = userController.user.value.galleryName;
  }

  Future<void> updateGalleryInfo() async {
    try {
      FullScreenLoader.openLoadingDialog(
          'updatingInfo'.tr, TImages.processingInfo);

      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        FullScreenLoader.stopLoading();
        TLoaders.warningSnackBar(
            title: 'internet'.tr, message: 'noInternet'.tr);
        return;
      }

      if (!updateGalleryFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();

        return;
      }

      Map<String, dynamic> name = {
        'galleryName': galleryNameController.text.trim(),
      };
      await userRepository.updateSingleField(name);

      userController.user.value.galleryName = galleryNameController.text.trim();

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
