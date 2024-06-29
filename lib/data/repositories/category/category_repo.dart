import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decordash/features/home/model/product_category_model.dart';
import 'package:decordash/features/home/model/vendor_category_model.dart';
import 'package:decordash/utils/logging/logger.dart';
import 'package:flutter/services.dart';
import 'package:decordash/common/widgets/loaders/loaders.dart';
import 'package:decordash/data/services/cloud_storage/firebase_storage_service.dart';
import 'package:decordash/features/home/model/category_model.dart';
import 'package:decordash/utils/exceptions/firebase_exceptions.dart';
import 'package:decordash/utils/exceptions/platform_exceptions.dart';
import 'package:decordash/utils/popups/full_screen_loader.dart';
import 'package:get/get.dart';

class CategoryRepo extends GetxController {
  static CategoryRepo get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<CategoryModel>> getAllCategories() async {
    return [
      CategoryModel(
          id: '1',
          image: 'assets/images/categories/chairs.png',
          name: 'Chair',
          isFeatured: true),
      CategoryModel(
          id: '2',
          image: 'assets/images/categories/sofas.png',
          name: 'Sofa',
          isFeatured: true),
      CategoryModel(
          id: '3',
          image: 'assets/images/categories/beds.png',
          name: 'Bed',
          isFeatured: true),
      CategoryModel(
          id: '4',
          image: 'assets/images/categories/tables.png',
          name: 'Table',
          isFeatured: true),

      /// Rooms
      CategoryModel(
        id: '8',
        image: 'assets/images/categories/living_room.png',
        name: 'Living Room',
        isFeatured: false,
        isRoom: true,
      ),
      CategoryModel(
        id: '9',
        image: 'assets/images/categories/bed_room.png',
        name: 'Bed Room',
        isFeatured: false,
        isRoom: true,
      ),
      CategoryModel(
        id: '10',
        image: 'assets/images/categories/desk_room.png',
        name: 'Desk Room',
        isFeatured: false,
        isRoom: true,
      ),

      /// Sub Categories
      CategoryModel(
          id: '12',
          image: 'assets/images/categories/chairs.png',
          name: 'Swivle Chairs',
          isFeatured: false,
          parentId: '1'),
    ];
  }

  Future<List<CategoryModel>> getSubCategories(String categoryId) async {
    if (categoryId == '1') {
      return [
        CategoryModel(
            id: '11',
            image: 'assets/images/categories/chairs.png',
            name: 'Wooden Chairs',
            isFeatured: false,
            parentId: '1'),
        CategoryModel(
            id: '12',
            image: 'assets/images/categories/chairs.png',
            name: 'Swivle Chairs',
            isFeatured: false,
            parentId: '1'),
      ];
    }
    if (categoryId == '2') {
      return [
        CategoryModel(
            id: '21',
            image: 'assets/images/categories/sofas.png',
            name: 'Couches',
            isFeatured: false,
            parentId: '2'),
      ];
    }
    if (categoryId == '3') {
      return [
        CategoryModel(
            id: '31',
            image: 'assets/images/categories/beds.png',
            name: 'Regular Beds',
            isFeatured: false,
            parentId: '3'),
      ];
    }
    if (categoryId == '4') {
      return [
        CategoryModel(
            id: '41',
            image: 'assets/images/categories/tables.png',
            name: 'wooden Tables',
            isFeatured: false,
            parentId: '4'),
      ];
    }
    if (categoryId == '8') {
      return [
        CategoryModel(
            id: '21',
            image: 'assets/images/categories/sofas.png',
            name: 'Couches',
            isFeatured: false,
            parentId: '2'),
        CategoryModel(
            id: '41',
            image: 'assets/images/categories/tables.png',
            name: 'wooden Tables',
            isFeatured: false,
            parentId: '4'),
        CategoryModel(
            id: '11',
            image: 'assets/images/categories/chairs.png',
            name: 'Wooden Chairs',
            isFeatured: false,
            parentId: '1'),
        CategoryModel(
            id: '12',
            image: 'assets/images/categories/chairs.png',
            name: 'Swivle Chairs',
            isFeatured: false,
            parentId: '1'),
      ];
    }

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
          'Uploading Data...', 'assets/animations/animation-of-docer.json');
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
