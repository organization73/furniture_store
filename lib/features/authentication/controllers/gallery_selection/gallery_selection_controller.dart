import 'package:decordash/data/repositories/authentication/authentication_repo.dart';
import 'package:decordash/features/authentication/model/gallery_selection/gallery_selection_model.dart';
import 'package:decordash/features/authentication/screens/gallery_selction/gallery_info.dart';
import 'package:decordash/features/personalization/controllers/user/user_controller.dart';
import 'package:get/get.dart';

class GallerySelectionController extends GetxController {
  final GallerySelectionModel model;

  GallerySelectionController._(this.model);

  static GallerySelectionController getInstance() {
    return Get.put(GallerySelectionController._(Get.find()));
  }

  final userController = UserController.instance;

  void navigateToNextScreen() {
    userController.updateAccountType(model.selectedOption.value);

    if (model.selectedOption.value == 0) {
      AuthenticatorRepo.instance.screenRedirect();
    } else {
      Get.to(
        () => GalleryInformationScreen(),
        duration: const Duration(milliseconds: 300),
        transition: Transition.rightToLeft,
      );
    }
  }
}
