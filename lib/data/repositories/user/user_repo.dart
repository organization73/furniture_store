import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decordashapp/utils/exceptions/exception_handler.dart';
import 'package:decordashapp/data/repositories/authentication/authentication_repo.dart';
import 'package:decordashapp/modules/personalization/models/user_model.dart';
import 'package:get/get.dart';

class UserRepo extends GetxService {
  static UserRepo get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveuserRecord(UserModel user) async {
    try {
      await _db.collection('Users').doc(user.id).set(user.toJson());
    } catch (e) {
      ExceptionHandler.handleAuthException(e);
      rethrow;
    }
  }

  Future<UserModel> fetchUserData() async {
    try {
      final documentSnapshot = await _db
          .collection('Users')
          .doc(AuthenticatorRepo.instance.authUser?.uid)
          .get();
      if (documentSnapshot.exists) {
        return UserModel.fromFirebaseDocument(documentSnapshot);
      } else {
        return UserModel.empty();
      }
    } catch (e) {
      ExceptionHandler.handleAuthException(e);
      rethrow;
    }
  }

  Future<void> updateUserData(UserModel updatedUser) async {
    try {
      await _db
          .collection('Users')
          .doc(updatedUser.id)
          .update(updatedUser.toJson());
    } catch (e) {
      ExceptionHandler.handleAuthException(e);
      rethrow;
    }
  }

  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _db
          .collection('Users')
          .doc(AuthenticatorRepo.instance.authUser?.uid)
          .update(json);
    } catch (e) {
      ExceptionHandler.handleAuthException(e);
      rethrow;
    }
  }

  Future<void> removeUserRecord(String userId) async {
    try {
      // Delete the user's document from the 'Users' collection
      await _db.collection('Users').doc(userId).delete();

      // Query the 'Products' collection for documents where 'userId' matches the user ID being removed
      final userProducts = await _db
          .collection('Products')
          .where('ProductDetails.productSeller.id', isEqualTo: userId)
          .get();
      final vendorRelation = await _db
          .collection('VendorCategory')
          .where('vendorId', isEqualTo: userId)
          .get();
      //TODO  delete user relation with products and categories
      // final categoryRelation = await _db
      //     .collection('ProductCategory')
      //     .where('productId', whereIn: userProducts.docs)
      //     .get();

      // Delete each product document found in the query
      for (var doc in userProducts.docs) {
        await _db.collection('Products').doc(doc.id).delete();
      }
      for (var doc in vendorRelation.docs) {
        await _db.collection('VendorCategory').doc(doc.id).delete();
      }
      // for (var doc in categoryRelation.docs) {
      //   await _db.collection('ProductCategory').doc(doc.id).delete();
      // }
    } catch (e) {
      ExceptionHandler.handleAuthException(e);
      rethrow;
    }
  }
}
