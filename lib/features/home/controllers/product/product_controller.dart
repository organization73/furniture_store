import 'package:decordash/common/widgets/loaders/loaders.dart';
import 'package:decordash/data/repositories/product/product_repo.dart';
import 'package:decordash/features/product/model/product_model.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();
  final isLoading = false.obs;
  final _productRepo = Get.put(ProductRepo());
  RxList<ProductModel> featuredProducts = <ProductModel>[].obs;

  @override
  void onInit() {
    // fetchFeaturedProducts();

    fetchProductsFromServer(1);
    super.onInit();
  }

  Future<void> fetchFeaturedProducts() async {
    try {
      isLoading.value = true;

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

  Future<List<ProductModel>> fetchProductsFromServer(int page) async {
    try {
      isLoading.value = true;
      var products = await _productRepo.fetchProductsFromServer(page);
      featuredProducts.value = products;
      return products;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'ohSnap'.tr, message: e.toString());
      return [];
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
