import 'package:furniture_store/data/repositories/authentication/auth_test.dart';
import 'package:furniture_store/features/authentication/controllers/soket.dart';
import 'package:furniture_store/features/personalization/controllers/user/user_controller.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  static ChatController get instance => Get.find();
  final socketService = SocketService();

  @override
  Future<void> onInit() async {
    super.onInit();
    await socketService.createSocketConnection();
    socketService.setupUser(UserController.instance.user!.id);
  }
}
