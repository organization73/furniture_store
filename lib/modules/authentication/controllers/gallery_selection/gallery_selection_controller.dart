import 'package:decordashapp/data/repositories/authentication/authentication_repo.dart';
import 'package:decordashapp/modules/authentication/model/gallery_selection/gallery_selection_model.dart';
import 'package:decordashapp/modules/authentication/screens/gallery_selction/gallery_info.dart';
import 'package:decordashapp/modules/profile/controllers/user_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class GallerySelectionController extends GetxController {
  final GallerySelectionModel model;

  GallerySelectionController._(this.model);
  final storage = GetStorage();

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
        () => const GalleryInformationScreen(),
        duration: const Duration(milliseconds: 300),
        transition: Transition.rightToLeft,
      );
    }
  }
}
