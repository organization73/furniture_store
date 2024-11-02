import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decordashapp/utils/exceptions/exception_handler.dart';
import 'package:decordashapp/modules/vendors/models/vendor_model.dart';
import 'package:get/get.dart';

class VendorRepo extends GetxController {
  static VendorRepo get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<VendorModel>> fetchAllVendors() async {
    try {
      final snapshot = await _db.collection('Vendors').get();

      final list = snapshot.docs
          .map((document) => VendorModel.fromFirebaseDocument(document))
          .toList();

      return list;
    } catch (e) {
      ExceptionHandler.handleAuthException(e);
      rethrow;
    }
  }

  Future<List<VendorModel>> getVendorsForCategory(categoryId) async {
    try {
      QuerySnapshot vendorCategoryQuery = await _db
          .collection('VendorCategory')
          .where('categoryId', isEqualTo: categoryId)
          .get();

      List<String> vendorIds = vendorCategoryQuery.docs
          .map((doc) => doc['vendorId'] as String)
          .toList();
      final vendorsQuery = await _db
          .collection('Vendors')
          .where(FieldPath.documentId, whereIn: vendorIds)
          .limit(1)
          .get();

      List<VendorModel> vendors = vendorsQuery.docs
          .map((doc) => VendorModel.fromFirebaseDocument(doc))
          .toList();
      return vendors;
    } catch (e) {
      ExceptionHandler.handleAuthException(e);
      rethrow;
    }
  }
}
