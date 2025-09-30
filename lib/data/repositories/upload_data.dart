import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decordash/data/dummy_data.dart';
import 'package:decordash/features/home/model/banners_model.dart';
import 'package:decordash/features/home/model/category_model.dart';
import 'package:decordash/features/home/model/product_category_model.dart';
import 'package:decordash/features/home/model/vendor_category_model.dart';
import 'package:decordash/features/home/model/vendor_model.dart';
import 'package:decordash/features/product/model/product_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class UploadDataRepository extends GetxController {
  static UploadDataRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<void> uploadData() async {
    try {
      await uploadCategories();
      await uploadVendors();
      await uploadProducts();
      await uploadBanners();
      await uploadProductCategories();
      await uploadVendorCategories();
    } on FirebaseException catch (e) {
      throw e.message!;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  Future<void> uploadCategories() async {
    try {
      final List<CategoryModel> categories = DummyData.categories;
      for (var category in categories) {
        await _db
            .collection('Categories')
            .doc(category.id)
            .set(category.toJson());
      }
    } catch (e) {
      throw 'Error uploading categories: $e';
    }
  }

  Future<void> uploadVendors() async {
    try {
      final List<VendorModel> vendors = DummyData.vendors;
      for (var vendor in vendors) {
        await _db.collection('Vendors').doc(vendor.id).set(vendor.toJson());
      }
    } catch (e) {
      throw 'Error uploading vendors: $e';
    }
  }

  Future<void> uploadProducts() async {
    try {
      final List<ProductModel> products = DummyData.products;
      for (var product in products) {
        await _db.collection('Products').doc(product.id).set(product.toJson());
      }
    } catch (e) {
      throw 'Error uploading products: $e';
    }
  }

  Future<void> uploadBanners() async {
    try {
      final List<BannersModel> banners = DummyData.banners;
      for (var banner in banners) {
        await _db.collection('Banners').add(banner.toJson());
      }
    } catch (e) {
      throw 'Error uploading banners: $e';
    }
  }

  Future<void> uploadProductCategories() async {
    try {
      final List<ProductCategoryModel> productCategories =
          DummyData.productCategories;
      for (var pc in productCategories) {
        await _db.collection('ProductCategory').add(pc.toJson());
      }
    } catch (e) {
      throw 'Error uploading product categories: $e';
    }
  }

  Future<void> uploadVendorCategories() async {
    try {
      final List<VendorCategoryModel> vendorCategories =
          DummyData.vendorsCategory;
      for (var vc in vendorCategories) {
        await _db.collection('VendorCategory').add(vc.toJson());
      }
    } catch (e) {
      throw 'Error uploading vendor categories: $e';
    }
  }
}