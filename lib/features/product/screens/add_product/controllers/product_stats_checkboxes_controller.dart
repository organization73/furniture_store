import 'package:decordash/features/product/screens/add_product/controllers/add_product_controller.dart';
import 'package:get/get.dart';

class ProductStatsCheckboxesController extends GetxController {
  final RxMap<String, bool> productStats;

  ProductStatsCheckboxesController()
      : productStats = AddProductController.instance.productStats;

  void updateProductStat(String key, bool newValue) {
    productStats[key] = newValue;
  }
}
