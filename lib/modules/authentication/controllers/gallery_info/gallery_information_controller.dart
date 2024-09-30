import 'package:decordashapp/data/repositories/user/user_repo.dart';
import 'package:decordashapp/data/services/location/location_services.dart';
import 'package:decordashapp/modules/personalization/controllers/user/user_controller.dart';
import 'package:decordashapp/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:decordashapp/common/widgets/loaders/loaders.dart';
import 'package:decordashapp/data/repositories/authentication/authentication_repo.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class GalleryInfoController extends GetxController {
  static GalleryInfoController get instance => Get.find();
  final storage = GetStorage();

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
      if (!formKey.currentState!.validate()) {
        return;
      }

      if (UserController.instance.user.value.galleryPicture.isEmpty) {
        TLoaders.warningSnackBar(
            title: 'Upload Gallery Picture',
            message: 'Please upload your gallery picture');
        return;
      }

      if (UserController.instance.user.value.galleryCertificate.isEmpty) {
        TLoaders.warningSnackBar(
            title: 'Upload Gallery Certificate',
            message: 'Please upload your gallery certificate or ID');
        return;
      }

      Map<String, dynamic> name = {
        'galleryName': galleryNameController.text.trim(),
        'galleryAddress': galleryAddressController.text.trim()
      };
      await UserRepo.instance.updateSingleField(name);

      UserController.instance.user.value.galleryName =
          galleryNameController.text.trim();
      UserController.instance.user.value.galleryAddress =
          galleryAddressController.text.trim();

      UserController.instance.user.refresh();

      storage.write('isGalleryInfoComp', true);

      AuthenticatorRepo.instance.screenRedirect();
    } catch (e) {
      TLoaders.errorSnackBar(title: 'ohSnap'.tr, message: e.toString());
    }
  }
}
