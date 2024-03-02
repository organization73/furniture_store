import 'package:furniture_store/data/repositories/authentication/api_services.dart';
import 'package:furniture_store/data/repositories/authentication/auth_test.dart';
import 'package:furniture_store/features/authentication/controllers/sign_up/sign_up_controller.dart';
import 'package:furniture_store/utils/helpers/network_manager.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';

class GeneralBinding extends Bindings {
  @override
  void dependencies() {
            Get.put(HttpService());

        Get.put(SignUpController());

    Get.put(AuthenticatorRepoTest());

    Get.put(NetworkManager());
  }
}
