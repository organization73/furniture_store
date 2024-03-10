// controller/balance_controller.dart
import 'package:decordash/features/ai/model/generative_ai/balance_model.dart';
import 'package:get/get.dart';

class BalanceController extends GetxController {
  static BalanceController get instance => Get.find();
  var balance = 0.0.obs;

  void fetchBalance() {
    BalanceModel().fetchBalance().then((fetchedBalance) {
      balance.value = fetchedBalance;
    });
  }
}
