import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decordash/common/widgets/loaders/loaders.dart';
import 'package:decordash/data/repositories/product/product_repo.dart';
import 'package:decordash/features/product/model/product_model.dart';
import 'package:get/get.dart';

class AllProductsController extends GetxController {
  static AllProductsController get instance => Get.find();

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    ProductRepo.pagenumber = 1;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    ProductRepo.pagenumber = 1;
  }

  final repo = ProductRepo.instance;
  final RxString selectedSortOption = 'Newest'.obs;
  final RxList<ProductModel> products = <ProductModel>[].obs;

  Future<List<ProductModel>> fetchProductsByQuery(Query? query) async {
    return [];
  }

  void sortProducts(String sortOption) {
    selectedSortOption.value = sortOption;

    switch (sortOption) {
      case 'Name':
        products.sort(
          (a, b) => a.productName.compareTo(b.productName),
        );
        break;
      case 'Higher Price':
        products.sort(
          (a, b) => b.productPrice.compareTo(a.productPrice),
        );
        break;
      case 'Lower Price':
        products.sort(
          (a, b) => a.productPrice.compareTo(b.productPrice),
        );
        break;
      case 'Sale':
        products.sort((a, b) {
          if (b.productSalePrice > 0) {
            return b.productSalePrice.compareTo(a.productSalePrice);
          } else if (a.productSalePrice > 0) {
            return -1;
          } else {
            return 1;
          }
        });
        break;
      case 'Newest':
        products.sort(
          (a, b) => a.productDetails.date!.compareTo(b.productDetails.date!),
        );
        break;
      default:
        products.sort(
          (a, b) => a.productName.compareTo(b.productName),
        );
    }
  }

  void assignProducts(List<ProductModel> products) {
    this.products.assignAll(products);
    sortProducts('Newest');
  }
}
