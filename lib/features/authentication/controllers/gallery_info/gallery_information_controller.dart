import 'package:flutter/material.dart';
import 'package:furniture_store/common/widgets/loaders/loaders.dart';
import 'package:furniture_store/data/repositories/authentication/authentication_repo.dart';
import 'package:furniture_store/features/authentication/model/gallery_info/gallery_information_model.dart';
import 'package:get/get.dart';

class GalleryInformationController extends GetxController {
  final GalleryInformationModel model;

  GalleryInformationController._(this.model);

  static GalleryInformationController getInstance() {
    return Get.put(GalleryInformationController._(Get.find()));
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController galleryNameController = TextEditingController();
  final TextEditingController galleryAddressController =
      TextEditingController();

  void validateAndSubmit() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    if (model.selectedImage.value == null) {
      // Handle file validation error
      TLoaders.warningSnackBar(
          title: 'Upload Gallery ID', message: 'Please upload your gallery ID');
      return;
    }

    // Proceed with submission logic
    AuthenticatorRepo.instance.screenRedirect();
    // Get.off(
    //   () => const SuccessScreen(
    //     screen: LoginSignUpScreen(),
    //   ),
    //   duration: const Duration(milliseconds: 300),
    //   transition: Transition.rightToLeft,
    // );
  }
}
