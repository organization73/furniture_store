import 'package:decordashapp/common/widgets/loaders/loaders.dart';
import 'package:decordashapp/data/repositories/authentication/authentication_repo.dart';
import 'package:get/get.dart';
import 'package:decordashapp/utils/helpers/network_manager.dart';

class NetworkController extends GetxController {
  static NetworkController get instance => Get.find();

  void retryConnection() {
    if (NetworkManager.instance.isOnline) {
      AuthenticatorRepo.instance.screenRedirect();
    } else {
      TLoaders.warningSnackBar(title: 'internet'.tr, message: 'noInternet'.tr);
    }
  }
}
