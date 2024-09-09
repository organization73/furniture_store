import 'package:decordashapp/data/dummy_data.dart';
import 'package:decordashapp/features/notifications/model/notifications_model.dart';
import 'package:get/get.dart';

class NotificationsController extends GetxController {
  static NotificationsController get instance => Get.find();

  List<Notifications> notiList = DummyData.notificationsList.obs;

  void removeNotification(int index) {
    notiList.removeAt(index);
  }
}
