import 'package:decordashapp/data/repositories/user/user_repo.dart';
import 'package:decordashapp/features/personalization/controllers/user/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:decordashapp/common/widgets/loaders/loaders.dart';
import 'package:decordashapp/data/repositories/authentication/authentication_repo.dart';
import 'package:get/get.dart';

class GalleryInfoController extends GetxController {
  static GalleryInfoController get instance => Get.find();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController galleryNameController = TextEditingController();
  final TextEditingController galleryAddressController =
      TextEditingController();

  final userController = UserController.instance;
  final userRepository = Get.put(UserRepo());

  Future<void> validateAndSubmit() async {
    try {
      if (!formKey.currentState!.validate()) {
        return;
      }

      if (userController.user.value.galleryPicture.isEmpty) {
        TLoaders.warningSnackBar(
            title: 'Upload Gallery Picture',
            message: 'Please upload your gallery picture');
        return;
      }

      if (userController.user.value.galleryCertificate.isEmpty) {
        TLoaders.warningSnackBar(
            title: 'Upload Gallery Certificate',
            message: 'Please upload your gallery certificate or ID');
        return;
      }

      Map<String, dynamic> name = {
        'galleryName': galleryNameController.text.trim(),
        'galleryAddress': galleryAddressController.text.trim()
      };
      await userRepository.updateSingleField(name);

      userController.user.value.galleryName = galleryNameController.text.trim();
      userController.user.value.galleryAddress =
          galleryAddressController.text.trim();

      userController.user.refresh();

      AuthenticatorRepo.instance.screenRedirect();
    } catch (e) {
      TLoaders.errorSnackBar(title: 'ohSnap'.tr, message: e.toString());
    }
  }
}
