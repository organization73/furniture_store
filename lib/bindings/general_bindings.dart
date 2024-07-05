import 'package:decordash/data/repositories/authentication/api_services.dart';
import 'package:decordash/features/chat/controllers/chat_controller.dart';
import 'package:decordash/features/favourits/controllers/favorite_controller.dart';
import 'package:decordash/features/home/controllers/home_page_controller.dart';
import 'package:decordash/features/personalization/controllers/user/user_controller.dart';
import 'package:decordash/utils/helpers/network_manager.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';

class GeneralBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.lazyPut(() => HttpService());
    Get.lazyPut(() => StartPageController());
    Get.lazyPut(() => ChatController());
    Get.lazyPut(() => FavoriteController());
    Get.lazyPut(() => UserController());
    Get.put(ChatController());
    Get.put(StartPageController());
    Get.put(UserController());
  }
}
