// gallery_selection_controller.dart
import 'package:furniture_store/features/authentication/model/gallery_selection/gallery_selection_model.dart';
import 'package:furniture_store/features/authentication/screens/gallery_info.dart';
import 'package:furniture_store/features/authentication/screens/login/login_screen.dart';
import 'package:furniture_store/features/authentication/screens/success_screen.dart';
import 'package:get/get.dart';

// gallery_selection_controller.dart
class GallerySelectionController extends GetxController {
  final GallerySelectionModel model;

  GallerySelectionController._(this.model);

  static GallerySelectionController getInstance() {
    return Get.put(GallerySelectionController._(Get.find()));
  }

  void navigateToNextScreen() {
    if (model.selectedOption.value == 0) {
      Get.off(
        () => const SuccessScreen(
          screen: LoginSignUpScreen(),
        ),
        duration: const Duration(milliseconds: 300),
        transition: Transition.rightToLeft,
      );
    } else {
      Get.off(
        () => const GalleryInformationScreen(),
        duration: const Duration(milliseconds: 300),
        transition: Transition.rightToLeft,
      );
    }
  }
}
