import 'dart:io';

import 'package:decordash/utils/logging/logger.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class FirebaseStorageServices extends GetxController {
  static FirebaseStorageServices get instance => Get.find();

  final _firebaseStorage = FirebaseStorage.instance;

  Future<Uint8List> getImageDatafromAssets(String path) async {
    try {
      if (path.startsWith('assets')) {
        LoggerHelper.info('ggggggggg');

        // Load image data from assets
        final byteData = await rootBundle.load(path);
        return byteData.buffer.asUint8List();
      } else {
        LoggerHelper.info('eeee');

        // Load image data from file path
        final file = File(path);
        return await file.readAsBytes();
      }
    } catch (e) {
      // Handle errors
      LoggerHelper.error('Error loading image data: $e');
      throw 'Error loading image data';
    }
  }

  Future<String> uploadImageData(
      String path, Uint8List image, String name) async {
    try {
      final ref = _firebaseStorage.ref(path).child(name);
      await ref.putData(image);
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      if (e is FirebaseException) {
        throw 'Firebase Exception: ${e.message}';
      } else if (e is SocketException) {
        throw 'Network Error: ${e.message}';
      } else if (e is PlatformException) {
        throw 'Platform Exception: ${e.message}';
      } else {
        throw 'Something went wrong, Please try again';
      }
    }
  }

  Future<String> uploadImageFile(String path, XFile image) async {
    try {
      final ref = _firebaseStorage.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      if (e is FirebaseException) {
        throw 'Firebase Exception: ${e.message}';
      } else if (e is SocketException) {
        throw 'Network Error: ${e.message}';
      } else if (e is PlatformException) {
        throw 'Platform Exception: ${e.message}';
      } else {
        throw 'Something went wrong, Please try again';
      }
    }
  }
}
