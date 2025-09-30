import 'package:decordash/data/repositories/notifications/notifications_repo.dart';
import 'package:decordash/features/notifications/model/notifications_model.dart';
import 'package:get/get.dart';

class NotificationsController extends GetxController {
  static NotificationsController get instance => Get.find();

  final _repo = Get.put(NotificationsRepo());
  final notifications = <Notifications>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    try {
      isLoading.value = true;
      final fetchedNotifications = await _repo.getNotifications();
      notifications.assignAll(fetchedNotifications);
    } catch (e) {
      // Handle error
    } finally {
      isLoading.value = false;
    }
  }

  void removeNotification(int index) {
    notifications.removeAt(index);
  }
}
