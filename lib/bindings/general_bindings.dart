import 'package:decordash/data/repositories/authentication/api_services.dart';
import 'package:decordash/features/personalization/controllers/user/user_controller.dart';
import 'package:decordash/utils/helpers/network_manager.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';

class GeneralBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.lazyPut(() => HttpService());
    Get.put(UserController());
  }
}
