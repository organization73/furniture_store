import 'package:furniture_store/global/global_variables.dart';
import 'package:get/get.dart';

class NotificationsController extends GetxController {
  static NotificationsController get instance => Get.find();
  var notiList = notificationsList.obs;

  void removeNotification(int index) {
    notiList.removeAt(index);
  }
}
