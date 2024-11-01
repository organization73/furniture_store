import 'package:decordashapp/data/repositories/user/user_repo.dart';
import 'package:decordashapp/modules/profile/controllers/user_controller.dart';
import 'package:decordashapp/utils/helpers/network_manager.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';

class GeneralBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.lazyPut<UserRepo>(() => UserRepo());
    Get.lazyPut<UserController>(() => UserController());
  }
}
