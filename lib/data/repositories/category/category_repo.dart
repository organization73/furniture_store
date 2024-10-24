import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decordashapp/data/services/cloud_storage/firebase_storage_service.dart';
import 'package:decordashapp/modules/home/model/rooms_model.dart';
import 'package:decordashapp/utils/constants/image_strings.dart';
import 'package:decordashapp/utils/exceptions/exception_handler.dart';
import 'package:decordashapp/modules/home/model/category_model.dart';
import 'package:decordashapp/utils/popups/full_screen_loader.dart';
import 'package:get/get.dart';

class CategoryRepo extends GetxController {
  static CategoryRepo get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final snapshot = await _db.collection('Categories').get();

      final list = snapshot.docs
          .map((document) => CategoryModel.fromFirebaseDocument(document))
          .toList();

      return list;
    } catch (e) {
      ExceptionHandler.handleAuthException(e);
      rethrow;
    }
  }

  Future<List<RoomModel>> getRooms() async {
    try {
      final snapshot = await _db.collection('Rooms').get();

      final list = snapshot.docs
          .map((document) => RoomModel.fromFirebaseDocument(document))
          .toList();

      return list;
    } catch (e) {
      ExceptionHandler.handleAuthException(e);
      rethrow;
    }
  }

  Future<List<CategoryModel>> getSubCategories(String categoryId) async {
    try {
      final snapshot = await _db
          .collection('Categories')
          .where('parentId', isEqualTo: categoryId)
          .get();

      final list = snapshot.docs
          .map((document) => CategoryModel.fromFirebaseDocument(document))
          .toList();

      return list;
    } catch (e) {
      ExceptionHandler.handleAuthException(e);
      rethrow;
    }
  }

  Future<void> uploadDummyData(
    List<CategoryModel> categories,
    List<RoomModel> rooms,
  ) async {
    try {
      FullScreenLoader.openLoadingDialog(
          'Uploading Data...', ImageStrings.processingInfo);
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
      for (var room in rooms) {
        final file = await storage.getImageDatafromAssets(room.image);
        final url = await storage.uploadImageData('Rooms', file, room.image);
        room.image = url;
        await _db.collection('Rooms').doc(room.id).set(room.toJson());
      }

      FullScreenLoader.stopLoading();
    } catch (e) {
      ExceptionHandler.handleAuthException(e);
      rethrow;
    }
  }
}
