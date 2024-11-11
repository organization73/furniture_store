import 'package:decordashapp/data/repositories/authentication/authentication_repo.dart';
import 'package:decordashapp/modules/authentication/screens/gallery_selction/gallery_info_screen.dart';
import 'package:get/get.dart';

class GallerySelectionController extends GetxController {
  static GallerySelectionController get instance => Get.find();

  final isGallerySelected = false.obs;

  void navigateToNextScreen() {
    if (!isGallerySelected.value) {
      AuthenticatorRepo.instance.screenRedirect();
    } else {
      Get.to(
        () => const GalleryInformationScreen(),
      );
    }
  }
}
