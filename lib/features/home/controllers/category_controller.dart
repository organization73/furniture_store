import 'package:decordash/common/widgets/loaders/loaders.dart';
import 'package:decordash/data/repositories/category/category_repo.dart';
import 'package:decordash/data/repositories/product/product_repo.dart';
import 'package:decordash/features/home/model/category_model.dart';
import 'package:decordash/features/home/model/product_model.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();
  final isLoading = false.obs;
  final _categoryRepo = Get.put(CategoryRepo());
  RxList<CategoryModel> allCatedories = <CategoryModel>[].obs;
  RxList<CategoryModel> featuredCatedories = <CategoryModel>[].obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  Future<void> fetchCategories() async {
    try {
      isLoading.value = true;
      final categories = await _categoryRepo.getAllCategories();

      allCatedories.assignAll(categories);

      featuredCatedories.assignAll(allCatedories
          .where((category) => category.isFeatured && category.parentId.isEmpty)
          .toList());
    } catch (e) {
      TLoaders.errorSnackBar(title: 'ohSnap'.tr, message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<ProductModel>> getCategoryProducts(
      {required String categoryId, int limit =4 }) async {
    try {
      final products = await ProductRepo.instance
          .getProductsForCategory(categoryId: categoryId, limit: limit);
      return products;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'ohSnap'.tr, message: e.toString());
      return [];
    }
  }
}
