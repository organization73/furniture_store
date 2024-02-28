import 'package:furniture_store/data/repositories/authentication/auth_test.dart';
import 'package:furniture_store/utils/helpers/network_manager.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';

class GeneralBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthenticatorRepoTest());

    Get.put(NetworkManager());
  }
}
