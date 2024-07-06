import 'package:decordash/data/repositories/user/user_repo.dart';
import 'package:decordash/features/authentication/screens/login/login_screen.dart';
import 'package:decordash/features/personalization/controllers/user/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:decordash/common/widgets/loaders/loaders.dart';
import 'package:get/get.dart';

class GalleryInfoController extends GetxController {
  static GalleryInfoController get instance => Get.find();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static bool isGalleryCertificateUploaded = false;

  final TextEditingController galleryNameController = TextEditingController();
  final TextEditingController galleryAddressController =
      TextEditingController();

  final userController = UserController.instance;

  Future<void> validateAndSubmit() async {
    try {
      if (!formKey.currentState!.validate()) {
        return;
      }

      if (userController.user.value.galleryCertificate.isEmpty) {
        TLoaders.warningSnackBar(
            title: 'Upload Gallery Certificate',
            message: 'Please upload your gallery certificate or ID');
        return;
      }
      if (isGalleryCertificateUploaded) {
        await UserRepo.instance.updateGalleryInfoTOServer(
            galleryNameController.text.trim(),
            galleryAddressController.text.trim(),
            userController.user.value.galleryCertificate);
      } else {
        TLoaders.warningSnackBar(
            title: 'Uploading Gallery Certificate is running...',
            message: 'Please waitto upload your gallery certificate or ID');
        return;
      }
      // TODO update Gallery Name and Address

      userController.user.value.galleryName = galleryNameController.text.trim();
      userController.user.value.galleryAddress =
          galleryAddressController.text.trim();

      userController.user.refresh();
      TLoaders.successSnackBar(
          title: "Your account created Successfully",
          message: "Please Login with your account.");
      Get.offAll(
        () => const LoginSignUpScreen(),
        duration: const Duration(milliseconds: 300),
        transition: Transition.rightToLeft,
      ); // Proceed with submission logic
    } catch (e) {
      TLoaders.errorSnackBar(title: 'ohSnap'.tr, message: e.toString());
    }
  }
}
