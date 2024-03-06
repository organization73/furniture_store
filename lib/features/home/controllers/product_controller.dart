import 'package:furniture_store/common/widgets/loaders/loaders.dart';
import 'package:furniture_store/data/repositories/product/product_repo.dart';
import 'package:furniture_store/features/home/model/product_model.dart';
import 'package:furniture_store/utils/logging/logger.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();
  final isLoading = false.obs;
  final _productRepo = Get.put(ProductRepo());
  RxList<ProductModel> allProducts = <ProductModel>[].obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;
      final products = await _productRepo.fetchProducts();

      allProducts.assignAll(products);
    } catch (e) {
      TLoaders.errorSnackBar(title: 'ohSnap'.tr, message: e.toString());
      LoggerHelper.error('eee', e);
    } finally {
      isLoading.value = false;
    }
  }
}
