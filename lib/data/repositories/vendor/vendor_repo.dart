import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decordash/data/repositories/authentication/api_services.dart';
import 'package:decordash/utils/logging/logger.dart';
import 'package:flutter/services.dart';
import 'package:decordash/common/widgets/loaders/loaders.dart';
import 'package:decordash/data/services/cloud_storage/firebase_storage_service.dart';
import 'package:decordash/features/home/model/vendor_model.dart';
import 'package:decordash/utils/exceptions/firebase_exceptions.dart';
import 'package:decordash/utils/exceptions/platform_exceptions.dart';
import 'package:decordash/utils/popups/full_screen_loader.dart';
import 'package:get/get.dart';

class VendorRepo extends GetxController {
  static VendorRepo get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<VendorModel>> fetchAllVendors() async {
    try {
      print("sssssss");
      final sna1 = await HttpService.instance.getUsers(1);
      final sna2 = await HttpService.instance.getUsers(2);
      final sna3 = await HttpService.instance.getUsers(3);
      final sna = sna1 + sna2 + sna3;
      // print(sna);
      print("bbbbbbbbbbbbbbbbbbb");
      final vendors = sna
          .map((vendor) => VendorModel.fromJsonToServerModel(vendor))
          .toList();
      for (var e in vendors) {
        print("name: ${e.name}");
        print("isFeatured: ${e.isFeatured}");
        print("isverified: ${e.isVerified}");
        print("imageUrl ${e.image}");
        print("prod ${e.productsCount}");
      }
      // print(vendors[0].name);
      return vendors;
      // final snapshot = await _db.collection('Vendors').get();

      // final list = snapshot.docs
      //     .map((document) => VendorModel.fromFirebaseDocument(document))
      //     .toList();

      // return list;
      // } on FirebaseException catch (e) {
      //   throw TFirebaseException(e.code).message;
      // } on PlatformException catch (e) {
      //   throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Please try again';
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
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }

  Future<void> uploadDummyData(List<VendorModel> vendors) async {
    try {
      FullScreenLoader.openLoadingDialog(
          'Uploading Data...', 'assets/animations/animation-of-docer.json');
      final storage = Get.put(FirebaseStorageServices());

      for (var vendor in vendors) {
        final file = await storage.getImageDatafromAssets(vendor.image);
        final url =
            await storage.uploadImageData('Vendors', file, vendor.image);
        vendor.image = url;
        await _db.collection('Vendors').doc(vendor.id).set(vendor.toJson());
      }
      FullScreenLoader.stopLoading();

      TLoaders.successSnackBar(
          title: 'Uploading Completed',
          message: 'All vendors data has been uploaded to firestore');
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      LoggerHelper.error('error', e);
      throw 'Something went wrong, Please try again';
    }
  }
}
