import 'package:decordash/common/widgets/loaders/loaders.dart';
import 'package:decordash/data/repositories/category/category_repo.dart';
import 'package:decordash/data/repositories/product/product_repo.dart';
import 'package:decordash/features/home/model/category_model.dart';
import 'package:decordash/features/home/model/vendor_model.dart';
import 'package:decordash/features/product/model/product_model.dart';
import 'package:decordash/utils/constants/enums.dart';
import 'package:decordash/utils/constants/image_strings.dart';
import 'package:decordash/utils/logging/logger.dart';
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
    return [ProductModel(
      id: 'c003',
      productName: 'Swivle Chair With Rest Arms',
      categoryId: '1',
      sku: 'AE51',
      productPrice: 520,
      productSalePrice: 450,
      isFeatured: true,
      rates: [],
      productImage: 'assets/images/products/chairs/003.png',
      onSale: true,
      productDetails: ProductDetails(
        condition: 'new',
        color: "Color(0xff389744)",
        productListImages: [
          'assets/images/products/chairs/002.png',
          'assets/images/products/chairs/004.png'
        ],
        productSpecs: {
          'ablakash': 'mdf',
          'fabric type': 'cloth',
          'fabric density': '60',
          'wood type': 'Abs',
        },
        productDesc:
            'A big swivle chair with unrivaled comfort and a striking visual experience.',
        productStats: ProductStats(
          delivery: true,
          negotiable: true,
          modifiable: true,
        ),
        productSeller: VendorModel(
            id: '3',
            image: TImages.user,
            location: 'Louxor',
            name: 'Khaled',
            accountType: AccountType.regular,
            isFeatured: false,
            productsCount: 5,
            isVerified: false),
      ),
    ),ProductModel(
      id: 'c003',
      productName: 'Swivle Chair With Rest Arms',
      categoryId: '1',
      sku: 'AE51',
      productPrice: 520,
      productSalePrice: 450,
      isFeatured: true,
      productImage: 'assets/images/products/chairs/003.png',
      onSale: true,
      productDetails: ProductDetails(
        condition: 'new',
        color: "Color(0xff389744)",
        productListImages: [
          'assets/images/products/chairs/002.png',
          'assets/images/products/chairs/004.png'
        ],
        productSpecs: {
          'ablakash': 'mdf',
          'fabric type': 'cloth',
          'fabric density': '60',
          'wood type': 'Abs',
        },
        productDesc:
            'A big swivle chair with unrivaled comfort and a striking visual experience.',
        productStats: ProductStats(
          delivery: true,
          negotiable: true,
          modifiable: true,
        ),
        productSeller: VendorModel(
            id: '3',
            image: TImages.user,
            location: 'Louxor',
            name: 'Khaled',
            accountType: AccountType.regular,
            isFeatured: false,
            productsCount: 5,
            isVerified: false),
      ),
    )];

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
