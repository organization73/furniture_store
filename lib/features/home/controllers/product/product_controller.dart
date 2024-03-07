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
  RxList<ProductModel> featuredProducts = <ProductModel>[].obs;

  @override
  void onInit() {
    fetchFeaturedProducts();
    super.onInit();
  }

  Future<void> fetchFeaturedProducts() async {
    try {
      isLoading.value = true;
      // final products = await _productRepo.fetchProducts();
      final featuredProducts = await _productRepo.fetchFeaturedProducts();

      // allProducts.assignAll(products);
      this.featuredProducts.assignAll(featuredProducts);
    } catch (e) {
      TLoaders.errorSnackBar(title: 'ohSnap'.tr, message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  double getProductPrice(ProductModel product) {
    return (product.onSale ? product.productSalePrice : product.productPrice);
  }

  String? calculateSalePercnetage(double originalPrice, double? salePrice) {
    if (salePrice == null || salePrice <= 0.0) return null;
    if (originalPrice <= 0) return null;

    double precnetage = ((originalPrice - salePrice) / originalPrice) * 100;
    return precnetage.toStringAsFixed(0);
  }
}
