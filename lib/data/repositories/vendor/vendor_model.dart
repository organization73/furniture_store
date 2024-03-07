import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:furniture_store/common/widgets/loaders/loaders.dart';
import 'package:furniture_store/data/services/cloud_storage/firebase_storage_service.dart';
import 'package:furniture_store/features/home/model/vendor_model.dart';
import 'package:furniture_store/utils/exceptions/firebase_exceptions.dart';
import 'package:furniture_store/utils/exceptions/platform_exceptions.dart';
import 'package:furniture_store/utils/popups/full_screen_loader.dart';
import 'package:get/get.dart';

class VendorRepo extends GetxController {
  static VendorRepo get instance => Get.find();

  final _db = FirebaseFirestore.instance;



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
        await _db
            .collection('Vendors')
            .doc(vendor.id)
            .set(vendor.toJson());
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
      throw 'Something went wrong, Please try again';
    }
  }
}
