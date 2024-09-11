// controller/balance_controller.dart
import 'package:decordashapp/features/ai/model/generative_ai/balance_model.dart';
import 'package:get/get.dart';

class BalanceController extends GetxController {
  static BalanceController get instance => Get.find();
  RxDouble balance = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchBalance();
  }

  void fetchBalance() {
    BalanceModel().fetchBalance().then((fetchedBalance) {
      balance.value = fetchedBalance;
    });
  }
}
