import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:decordashapp/data/repositories/authentication/authentication_repo.dart';
import 'package:decordashapp/features/personalization/models/user_model.dart';
import 'package:decordashapp/utils/exceptions/firebase_exceptions.dart';
import 'package:decordashapp/utils/exceptions/format_exceptions.dart';
import 'package:decordashapp/utils/exceptions/platform_exceptions.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UserRepo extends GetxController {
  static UserRepo get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveuserRecord(UserModel user) async {
    try {
      await _db.collection('Users').doc(user.id).set(user.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Please try again';
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
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }

  Future<void> updateUserData(UserModel updatedUser) async {
    try {
      await _db
          .collection('Users')
          .doc(updatedUser.id)
          .update(updatedUser.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }

  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _db
          .collection('Users')
          .doc(AuthenticatorRepo.instance.authUser?.uid)
          .update(json);
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Please try again';
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
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }

  Future<String> uploadImage(String path, XFile image) async {
    try {
      final ref = FirebaseStorage.instance.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }
}
