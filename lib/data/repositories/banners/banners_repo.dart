import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decordashapp/utils/exceptions/exception_handler.dart';
import 'package:decordashapp/modules/home/model/banners_model.dart';
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
}
