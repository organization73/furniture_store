import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decordashapp/features/home/model/product_category_model.dart';
import 'package:decordashapp/features/home/model/vendor_category_model.dart';
import 'package:decordashapp/utils/constants/image_strings.dart';
import 'package:flutter/services.dart';
import 'package:decordashapp/common/widgets/loaders/loaders.dart';
import 'package:decordashapp/data/services/cloud_storage/firebase_storage_service.dart';
import 'package:decordashapp/features/home/model/category_model.dart';
import 'package:decordashapp/utils/exceptions/firebase_exceptions.dart';
import 'package:decordashapp/utils/exceptions/platform_exceptions.dart';
import 'package:decordashapp/utils/popups/full_screen_loader.dart';
import 'package:get/get.dart';

class CategoryRepo extends GetxController {
  static CategoryRepo get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final snapshot = await _db.collection('Categories').get();

      final list = snapshot.docs
          .map((document) => CategoryModel.fromFirebaseDocument(document))
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

  Future<List<CategoryModel>> getSubCategories(String categoryId) async {
    try {
      final snapshot = await _db
          .collection('Categories')
          .where('parentId', isEqualTo: categoryId)
          .get();

      final list = snapshot.docs
          .map((document) => CategoryModel.fromFirebaseDocument(document))
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

  Future<void> uploadDummyData(
      List<CategoryModel> categories,
      List<ProductCategoryModel> relations,
      List<VendorCategoryModel> vendorsCategory) async {
    try {
      FullScreenLoader.openLoadingDialog(
          'Uploading Data...', TImages.processingInfo);
      final storage = Get.put(FirebaseStorageServices());

      for (var category in categories) {
        final file = await storage.getImageDatafromAssets(category.image);
        final url =
            await storage.uploadImageData('Categories', file, category.image);
        category.image = url;
        await _db
            .collection('Categories')
            .doc(category.id)
            .set(category.toJson());
      }
      for (var relation in relations) {
        await _db.collection('ProductCategory').add(relation.toJson());
      }
      for (var relation in vendorsCategory) {
        await _db.collection('VendorCategory').add(relation.toJson());
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
