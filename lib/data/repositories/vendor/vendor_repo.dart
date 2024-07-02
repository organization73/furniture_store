import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decordash/data/repositories/authentication/api_services.dart';
import 'package:decordash/data/repositories/product/product_repo.dart';
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
      final sna1 = await HttpService.instance.getUsers(1);
      final sna2 = await HttpService.instance.getUsers(2);
      final sna3 = await HttpService.instance.getUsers(3);
      final sna = sna1 + sna2 + sna3;
      final vendors = sna
          .map((vendor) => VendorModel.fromJsonToServerModel(vendor))
          .toList();
      
      // print(vendors[0].name);
      return vendors;
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }

  Future<List<VendorModel>> getVendorsForCategory(categoryId) async {
    var pro = await ProductRepo.instance
        .getProductsForCategory(1, categoryId: categoryId);

    var vs = pro
        .map((e) => VendorModel(
          productsCount: e.productDetails.productSeller.productsCount,
            image: e.productDetails.productSeller.image,
            location: "Egypt",
            name: e.productDetails.productSeller.name,
            id: e.productDetails.productSeller.id))
        .toList();

    var uniqueVendors = <VendorModel>[];
    Map<String, bool> isExist = {};
    for (var vendor in vs) {
      print("vendor.id ${vendor.id}");
      if (isExist[vendor.id] == true) continue;
      isExist[vendor.id] = true;
      uniqueVendors.add(vendor);
    }
    return uniqueVendors;
    // return vs;
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
