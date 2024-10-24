import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decordashapp/utils/exceptions/exception_handler.dart';
import 'package:decordashapp/modules/product/model/product_model.dart';
import 'package:decordashapp/utils/exceptions/firebase_exceptions.dart';
import 'package:get/get.dart';

class ProductRepo extends GetxController {
  static ProductRepo get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<ProductModel>> fetchProducts() async {
    try {
      final snapshot = await _db.collection('Products').get();

      final list = snapshot.docs
          .map((document) => ProductModel.fromFirebaseDocument(document))
          .toList();

      return list;
    } catch (e) {
      ExceptionHandler.handleAuthException(e);
      rethrow;
    }
  }

  Future<List<ProductModel>> searchProducts(String query) async {
    try {
      // Fetch a larger set of documents
      final snapshot = await _db.collection('Products').get();

      // Filter documents on the client side
      final list = snapshot.docs
          .where((document) => document['productName']
              .toLowerCase()
              .contains(query.toLowerCase()))
          .map((document) => ProductModel.fromFirebaseDocument(document))
          .toList();

      return list;
    } catch (e) {
      ExceptionHandler.handleAuthException(e);
      rethrow;
    }
  }

  Future<List<ProductModel>> fetchFeaturedProducts() async {
    try {
      final snapshot = await _db
          .collection('Products')
          .where('isFeatured', isEqualTo: true)
          .limit(4)
          .get();

      final list = snapshot.docs
          .map((document) => ProductModel.fromFirebaseDocument(document))
          .toList();

      return list;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } catch (e) {
      ExceptionHandler.handleAuthException(e);
      rethrow;
    }
  }

  Future<List<ProductModel>> fetchAllFeaturedProducts() async {
    try {
      final snapshot = await _db
          .collection('Products')
          .where('isFeatured', isEqualTo: true)
          .get();

      final list = snapshot.docs
          .map((document) => ProductModel.fromFirebaseDocument(document))
          .toList();

      return list;
    } catch (e) {
      ExceptionHandler.handleAuthException(e);
      rethrow;
    }
  }

  Future<List<ProductModel>> fetchProductsByQuery(Query query) async {
    try {
      final querySnapshot = await query.get();
      final List<ProductModel> productList = querySnapshot.docs
          .map((doc) => ProductModel.fromFirebaseDocument(doc))
          .toList();
      return productList;
    } catch (e) {
      ExceptionHandler.handleAuthException(e);
      rethrow;
    }
  }

  Future<List<ProductModel>> getFavouriteProducts(
      List<String> productIds) async {
    try {
      final snapshot = await _db
          .collection('Products')
          .where(FieldPath.documentId, whereIn: productIds)
          .get();
      return snapshot.docs
          .map((querySnapshot) =>
              ProductModel.fromFirebaseDocument(querySnapshot))
          .toList();
    } catch (e) {
      ExceptionHandler.handleAuthException(e);
      rethrow;
    }
  }

  Future<List<ProductModel>> getProductsForVendor(
      {required String vendorId, int limit = -1}) async {
    try {
      final qureySnapshot = limit == -1
          ? await _db
              .collection('Products')
              .where('ProductDetails.productSeller.id', isEqualTo: vendorId)
              .get()
          : await _db
              .collection('Products')
              .where('ProductDetails.productSeller.id', isEqualTo: vendorId)
              .limit(limit)
              .get();

      final products = qureySnapshot.docs
          .map((doc) => ProductModel.fromFirebaseDocument(doc))
          .toList();
      return products;
    } catch (e) {
      ExceptionHandler.handleAuthException(e);
      rethrow;
    }
  }

  Future<List<ProductModel>> getProductsForCategory(
      {required String categoryId, int limit = -1}) async {
    try {
      final productCategoryQuery = limit == -1
          ? await _db
              .collection('ProductCategory')
              .where('categoryId', isEqualTo: categoryId)
              .get()
          : await _db
              .collection('ProductCategory')
              .where('categoryId', isEqualTo: categoryId)
              .limit(limit)
              .get();

      final productsIds = productCategoryQuery.docs
          .map((doc) => doc['productId'] as String)
          .toList();
      final productsQuery = await _db
          .collection('Products')
          .where(FieldPath.documentId, whereIn: productsIds)
          .get();

      List<ProductModel> products = productsQuery.docs
          .map((doc) => ProductModel.fromFirebaseDocument(doc))
          .toList();

      return products;
    } catch (e) {
      ExceptionHandler.handleAuthException(e);
      rethrow;
    }
  }

  Future<void> uploadProductToDatabase(ProductModel product) async {
    // try {
    //   final storage = Get.put(FirebaseStorageServices());
    //   final mainImageFile =
    //       await storage.getImageDatafromAssets(product.productImage);

    //   final mainImageUrl = await storage.uploadImageData(
    //       'Products', mainImageFile, product.productImage);
    //   product.productImage = mainImageUrl;

    //   for (var imagePath in product.productDetails.productListImages) {
    //     final imageFile = await storage.getImageDatafromAssets(imagePath);
    //     final imageUrl =
    //         await storage.uploadImageData('Products', imageFile, imagePath);

    //     product.productDetails.productListImages = product
    //         .productDetails.productListImages
    //         .map((path) => path == imagePath ? imageUrl : path)
    //         .toList();
    //   }

    //   await _db.collection('Products').doc(product.id).set(product.toJson());

    //   await _db.collection('ProductCategory').add(ProductCategoryModel(
    //           productId: product.id, categoryId: product.categoryId)
    //       .toJson());

    //   await _db.collection('VendorCategory').add(VendorCategoryModel(
    //           vendorId: product.productDetails.productSeller.id,
    //           categoryId: product.categoryId)
    //       .toJson());
    // } catch (e) {
    //   ExceptionHandler.handleAuthException(e);
    //   rethrow;
    // }
  }
}
