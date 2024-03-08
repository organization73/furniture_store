import 'package:furniture_store/common/widgets/loaders/loaders.dart';
import 'package:furniture_store/data/repositories/product/product_repo.dart';
import 'package:furniture_store/data/repositories/vendor/vendor_repo.dart';
import 'package:furniture_store/features/home/model/product_model.dart';
import 'package:furniture_store/features/home/model/vendor_model.dart';
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

  Future<List<ProductModel>> getVendorProducts(String vendorId) async {
    try {
      final products =
          await ProductRepo.instance.getProductsForVendor(vendorId: vendorId);
      return products;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'ohSnap'.tr, message: e.toString());
      return [];
    }
  }
}
