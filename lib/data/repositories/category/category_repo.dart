import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:furniture_store/features/home/model/category_model.dart';
import 'package:furniture_store/utils/exceptions/firebase_exceptions.dart';
import 'package:furniture_store/utils/exceptions/platform_exceptions.dart';
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
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }
}
