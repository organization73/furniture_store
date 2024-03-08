import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:furniture_store/common/widgets/loaders/loaders.dart';
import 'package:furniture_store/data/services/cloud_storage/firebase_storage_service.dart';
import 'package:furniture_store/features/home/model/product_model.dart';
import 'package:furniture_store/utils/exceptions/firebase_exceptions.dart';
import 'package:furniture_store/utils/exceptions/platform_exceptions.dart';
import 'package:furniture_store/utils/popups/full_screen_loader.dart';
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
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Please try again';
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
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Please try again';
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
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }

  Future<List<ProductModel>> fetchProductsByQuery(Query query) async {
    try {
      final querySnapshot = await query.get();
      final List<ProductModel> productList = querySnapshot.docs
          .map((doc) => ProductModel.fromFirebaseDocument(doc))
          .toList();
      return productList;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Please try again';
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
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }

  Future<void> uploadProductsToFirestore(List<ProductModel> products) async {
    try {
      FullScreenLoader.openLoadingDialog(
          'Uploading Data...', 'assets/animations/animation-of-docer.json');

      final storage = Get.put(FirebaseStorageServices());

      for (var product in products) {
        // Upload main product image
        final mainImageFile =
            await storage.getImageDatafromAssets(product.productImage);
        final mainImageUrl = await storage.uploadImageData(
            'Products', mainImageFile, product.productImage);
        product.productImage = mainImageUrl;

        // Upload product list images
        for (var imagePath in product.productDetails.productListImages) {
          final imageFile = await storage.getImageDatafromAssets(imagePath);
          final imageUrl =
              await storage.uploadImageData('Products', imageFile, imagePath);
          // Update the product list images with the new URLs
          product.productDetails.productListImages = product
              .productDetails.productListImages
              .map((path) => path == imagePath ? imageUrl : path)
              .toList();
        }

        // Update Firestore document with the new image URLs
        await _db.collection('Products').doc(product.id).set(product.toJson());
      }
      FullScreenLoader.stopLoading();

      TLoaders.successSnackBar(
          title: 'Uploading Completed',
          message: 'All categories data has been uploaded to firestore');
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }

  Future<void> addProduct(ProductModel product) async {
    try {
      FullScreenLoader.openLoadingDialog(
          'Uploading Data...', 'assets/animations/animation-of-docer.json');

      final CollectionReference products = _db.collection('Products');

      // Check if a product with the same ID already exists
      final DocumentSnapshot existingProduct =
          await products.doc(product.id).get();

      if (existingProduct.exists) {
        // Display a message if the product already exists
        FullScreenLoader.stopLoading();

        TLoaders.warningSnackBar(
            title: 'Product Exist',
            message: 'A product with the same ID exits');
        return;
      } else {
        // Add the new product if it's unique
        await products.doc(product.id).set(product.toJson());
      }

      FullScreenLoader.stopLoading();

      TLoaders.successSnackBar(
          title: 'Uploading Completed',
          message: 'All categories data has been uploaded to firestore');
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }
}
