import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:decordash/common/widgets/loaders/loaders.dart';
import 'package:decordash/data/services/cloud_storage/firebase_storage_service.dart';
import 'package:decordash/features/home/model/banners_model.dart';
import 'package:decordash/utils/exceptions/firebase_exceptions.dart';
import 'package:decordash/utils/exceptions/platform_exceptions.dart';
import 'package:decordash/utils/popups/full_screen_loader.dart';
import 'package:get/get.dart';

class BannersRepo extends GetxController {
  static BannersRepo get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<BannersModel>> fetchBanners() async {
    try {
      final snapshot = await _db
          .collection('Banners')
          .where('active', isEqualTo: true)
          .get();

      final list = snapshot.docs
          .map((document) => BannersModel.fromFirebaseDocument(document))
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

  Future<void> uploadDummyData(List<BannersModel> banners) async {
    try {
      FullScreenLoader.openLoadingDialog(
          'Uploading Data...', 'assets/animations/animation-of-docer.json');
      final storage = Get.put(FirebaseStorageServices());

      for (var banner in banners) {
        final file = await storage.getImageDatafromAssets(banner.image);
        final url =
            await storage.uploadImageData('Banners', file, banner.image);
        banner.image = url;
        await _db.collection('Banners').add(banner.toJson());
      }
      FullScreenLoader.stopLoading();

      TLoaders.successSnackBar(
          title: 'Uploading Completed',
          message: 'All banners data has been uploaded to firestore');
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }
}
