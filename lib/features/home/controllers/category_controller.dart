import 'package:decordashapp/common/widgets/loaders/loaders.dart';
import 'package:decordashapp/data/repositories/category/category_repo.dart';
import 'package:decordashapp/data/repositories/product/product_repo.dart';
import 'package:decordashapp/features/home/model/category_model.dart';
import 'package:decordashapp/features/product/model/product_model.dart';
import 'package:decordashapp/utils/logging/logger.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();
  final isLoading = false.obs;
  final _categoryRepo = Get.put(CategoryRepo());
  RxList<CategoryModel> allCatedories = <CategoryModel>[].obs;
  RxList<CategoryModel> featuredCatedories = <CategoryModel>[].obs;
  RxList<CategoryModel> roomsCatedories = <CategoryModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      isLoading.value = true;
      final categories = await _categoryRepo.getAllCategories();

      allCatedories.assignAll(categories);

      featuredCatedories.assignAll(allCatedories
          .where((category) => category.isFeatured && category.parentId.isEmpty)
          .toList());
      roomsCatedories.assignAll(allCatedories
          .where((category) => category.isRoom && category.parentId.isEmpty)
          .toList());
    } catch (e) {
      TLoaders.errorSnackBar(title: 'ohSnap'.tr, message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<CategoryModel>> getSubCategories(String categoryId) async {
    try {
      final subCategories = await _categoryRepo.getSubCategories(categoryId);
      return subCategories;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'ohSnap'.tr, message: e.toString());
      return [];
    }
  }

  Future<List<ProductModel>> getCategoryProducts(
      {required String categoryId, int limit = 4}) async {
    try {
      final products = await ProductRepo.instance
          .getProductsForCategory(categoryId: categoryId, limit: limit);
      return products;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'ohSnap'.tr, message: e.toString());
      LoggerHelper.error(e.toString());
      return [];
    }
  }
}
