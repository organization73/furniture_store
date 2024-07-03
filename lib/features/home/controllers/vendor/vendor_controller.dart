import 'package:decordash/common/widgets/loaders/loaders.dart';
import 'package:decordash/data/repositories/product/product_repo.dart';
import 'package:decordash/data/repositories/vendor/vendor_repo.dart';
import 'package:decordash/features/product/model/product_model.dart';
import 'package:decordash/features/home/model/vendor_model.dart';
import 'package:get/get.dart';

class VendorController extends GetxController {
  static VendorController get instance => Get.find();
  RxBool isLoading = true.obs;
  final _vendorRepo = Get.put(VendorRepo());

  final RxList<VendorModel> featuredVendors = <VendorModel>[].obs;
  RxList<VendorModel> allVendors = <VendorModel>[].obs;
  static int vendorsPageNumber = 1;
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    vendorsPageNumber = 1;
  }

  @override
  void onInit() {
    vendorsPageNumber = 1;
    fetchFeaturedVendors();
    super.onInit();
  }

  Future<void> fetchFeaturedVendors() async {
    try {
      isLoading.value = true;
      final vendors =
          await _vendorRepo.fetchAllVendors(page: vendorsPageNumber);

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
