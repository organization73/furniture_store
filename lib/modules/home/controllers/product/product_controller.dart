import 'package:decordashapp/common/widgets/loaders/loaders.dart';
import 'package:decordashapp/data/repositories/product/product_repo.dart';
import 'package:decordashapp/modules/product/model/product_model.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();
  final isLoading = false.obs;
  final _productRepo = Get.put(ProductRepo());
  RxList<ProductModel> featuredProducts = <ProductModel>[].obs;

  @override
  void onInit() {
    fetchFeaturedProducts();
    super.onInit();
  }

  Future<void> fetchFeaturedProducts() async {
    try {
      isLoading.value = true;
      final featuredProducts = await _productRepo.fetchFeaturedProducts();

      this.featuredProducts.assignAll(featuredProducts);
    } catch (e) {
      TLoaders.errorSnackBar(title: 'ohSnap'.tr, message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<ProductModel>> fetchAllFeaturedProducts() async {
    try {
      final products = await _productRepo.fetchFeaturedProducts();
      return products;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'ohSnap'.tr, message: e.toString());
      return [];
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
