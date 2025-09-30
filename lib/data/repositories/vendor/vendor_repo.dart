import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decordash/features/home/model/vendor_model.dart';
import 'package:decordash/utils/exceptions/firebase_exceptions.dart';
import 'package:decordash/utils/exceptions/platform_exceptions.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class VendorRepo extends GetxController {
  static VendorRepo get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<VendorModel>> getFeaturedVendors() async {
    try {
      final snapshot = await _db
          .collection('Vendors')
          .where('isFeatured', isEqualTo: true)
          .limit(4)
          .get();

      return snapshot.docs
          .map((document) => VendorModel.fromFirebaseDocument(document))
          .toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  Future<List<VendorModel>> getAllVendors() async {
    try {
      final snapshot = await _db.collection('Vendors').get();
      return snapshot.docs
          .map((document) => VendorModel.fromFirebaseDocument(document))
          .toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  Future<List<VendorModel>> getVendorsForCategory(
      {required String categoryId}) async {
    try {
      QuerySnapshot vendorCategoryQuery = await _db
          .collection('VendorCategory')
          .where('categoryId', isEqualTo: categoryId)
          .get();

      List<String> vendorIds = vendorCategoryQuery.docs
          .map((doc) => doc['vendorId'] as String)
          .toList();

      if (vendorIds.isEmpty) return [];

      final vendorsQuery = await _db
          .collection('Vendors')
          .where(FieldPath.documentId, whereIn: vendorIds)
          .get();

      return vendorsQuery.docs
          .map((doc) => VendorModel.fromFirebaseDocument(doc))
          .toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }
}
