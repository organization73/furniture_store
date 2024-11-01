import 'package:decordashapp/data/repositories/user/user_repo.dart';
import 'package:decordashapp/data/services/location/location_services.dart';
import 'package:decordashapp/modules/profile/controllers/user_controller.dart';
import 'package:decordashapp/utils/constants/enums.dart';
import 'package:decordashapp/utils/constants/image_strings.dart';
import 'package:decordashapp/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:decordashapp/common/widgets/loaders/loaders.dart';
import 'package:decordashapp/data/repositories/authentication/authentication_repo.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class GalleryInfoController extends GetxController {
  static GalleryInfoController get instance => Get.find();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController galleryNameController = TextEditingController();
  final TextEditingController galleryAddressController =
      TextEditingController();

  final locationController = Get.put(LoacationServices());

  Future<void> getLocation() async {
    try {
      FullScreenLoader.openSmallLoadingDialog('updatingInfo'.tr);
      setLocaleIdentifier(Get.locale!.toLanguageTag());
      Position position = await locationController.determinePosition();
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[0];

      galleryAddressController.text = '${place.locality},${place.street}';
      FullScreenLoader.stopLoading();
    } catch (e) {
      FullScreenLoader.stopLoading();

      TLoaders.errorSnackBar(title: 'ohSnap'.tr, message: e.toString());
    }
  }

  Future<void> validateAndSubmit() async {
    try {
      FullScreenLoader.openLoadingDialog(
          'processingLoading'.tr, ImageStrings.processingInfo);
      if (!formKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();

        return;
      }

      if (UserController.instance.user.value.galleryPicture.isEmpty) {
        FullScreenLoader.stopLoading();

        TLoaders.warningSnackBar(
            title: 'Upload Gallery Picture',
            message: 'Please upload your gallery picture');
        return;
      }

      if (UserController.instance.user.value.galleryCertificate.isEmpty) {
        FullScreenLoader.stopLoading();

        TLoaders.warningSnackBar(
            title: 'Upload Gallery Certificate',
            message: 'Please upload your gallery certificate or ID');
        return;
      }

      Map<String, dynamic> name = {
        'galleryName': galleryNameController.text.trim(),
        'galleryAddress': galleryAddressController.text.trim(),
        'accountType': 'gallery'
      };
      await UserRepo.instance.updateSingleField(name);

      UserController.instance.user.value.galleryName =
          galleryNameController.text.trim();
      UserController.instance.user.value.galleryAddress =
          galleryAddressController.text.trim();
      UserController.instance.user.value.accountType = AccountType.gallery;

      UserController.instance.user.refresh();
      FullScreenLoader.stopLoading();

      AuthenticatorRepo.instance.screenRedirect();
    } catch (e) {
      FullScreenLoader.stopLoading();

      TLoaders.errorSnackBar(title: 'ohSnap'.tr, message: e.toString());
    }
  }
}
