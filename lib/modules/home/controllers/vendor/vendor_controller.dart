import 'package:decordashapp/common/widgets/loaders/loaders.dart';
import 'package:decordashapp/data/repositories/product/product_repo.dart';
import 'package:decordashapp/data/repositories/vendor/vendor_repo.dart';
import 'package:decordashapp/modules/product/model/product_model.dart';
import 'package:decordashapp/modules/vendors/models/vendor_model.dart';
import 'package:get/get.dart';

class VendorController extends GetxController {
  static VendorController get instance => Get.find();
  RxBool isLoading = true.obs;
  final _vendorRepo = Get.put(VendorRepo());

  final RxList<VendorModel> featuredVendors = <VendorModel>[].obs;
  final RxList<VendorModel> allVendors = <VendorModel>[].obs;

  @override
  void onInit() {
    fetchFeaturedVendors();
    super.onInit();
  }

  Future<void> fetchFeaturedVendors() async {
    try {
      isLoading.value = true;
      final vendors = await _vendorRepo.fetchAllVendors();

      allVendors.assignAll(vendors);
      featuredVendors.assignAll(
          allVendors.where((vendor) => vendor.isFeatured ?? false).take(4));
    } catch (e) {
      TLoaders.errorSnackBar(title: 'ohSnap'.tr, message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<VendorModel>> getVendorsForCategory(String categoryId) async {
    try {
      final vendors =
          await VendorRepo.instance.getVendorsForCategory(categoryId);
      return vendors;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'ohSnap'.tr, message: e.toString());
      return [];
    }
  }

  Future<List<ProductModel>> getVendorProducts(
      {required String vendorId, int limit = -1}) async {
    try {
      final products = await ProductRepo.instance
          .getProductsForVendor(vendorId: vendorId, limit: limit);
      return products;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'ohSnap'.tr, message: e.toString());
      return [];
    }
  }
}
