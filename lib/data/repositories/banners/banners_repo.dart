import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decordashapp/data/services/cloud_storage/firebase_storage_service.dart';
import 'package:decordashapp/utils/constants/image_strings.dart';
import 'package:decordashapp/utils/exceptions/exception_handler.dart';
import 'package:decordashapp/modules/home/model/banners_model.dart';
import 'package:decordashapp/utils/popups/full_screen_loader.dart';
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
    } catch (e) {
      ExceptionHandler.handleAuthException(e);
      rethrow;
    }
  }

  Future<void> uploadDummyData(List<BannersModel> banners) async {
    try {
      FullScreenLoader.openLoadingDialog(
          'Uploading Data...', ImageStrings.processingInfo);
      final storage = Get.put(FirebaseStorageServices());

      for (var banner in banners) {
        final file = await storage.getImageDatafromAssets(banner.image);
        final url =
            await storage.uploadImageData('Banners', file, banner.image);
        banner.image = url;
        await _db.collection('Banners').add(banner.toJson());
      }
      FullScreenLoader.stopLoading();
    } catch (e) {
      ExceptionHandler.handleAuthException(e);
      rethrow;
    }
  }
}
