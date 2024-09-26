import 'dart:io';

import 'package:decordashapp/common/widgets/loaders/loaders.dart';
import 'package:decordashapp/modules/product/screens/add_product/controllers/add_product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class UploadImageFromGalleryController extends GetxController {
  static UploadImageFromGalleryController get instance => Get.find();

  Future<void> pickImagesFromGallery() async {
    final ImagePicker picker = ImagePicker();
    try {
      final List<XFile> pickedFiles = await picker.pickMultiImage();

      if (pickedFiles.isNotEmpty) {
        AddProductController.instance.pickedImagePaths
            .addAll(pickedFiles.map((file) => file.path));
      }
    } catch (e) {
      TLoaders.errorSnackBar(
          title: 'Error', message: 'Error Loading the image');
    }
  }

  Future<void> takePhoto() async {
    final ImagePicker picker = ImagePicker();

    // Check if camera permissions are granted
    PermissionStatus status = await Permission.camera.status;
    if (status.isGranted) {
      try {
        // Take a photo using the camera
        final XFile? takenPhoto =
            await picker.pickImage(source: ImageSource.camera);

        if (takenPhoto != null) {
          AddProductController.instance.pickedImagePaths.add(takenPhoto.path);
        }
      } catch (e) {
        TLoaders.errorSnackBar(
            title: 'Error', message: 'Error Loading the image');
      }
    } else {
      // If permissions are not granted, show a dialog to request them
      showAlertDialog();
    }
  }

  void deleteImage(int index) {
    AddProductController.instance.pickedImagePaths.removeAt(index);
  }

  void showAlertDialog() async {
    bool isGranted = await Permission.camera.request().isGranted;
    if (!isGranted) {
      Get.dialog(
        AlertDialog(
          title: const Text('Pemission Needed'),
          content: const Text('Camera permission is needed'),
          actions: <Widget>[
            TextButton(
              child: const Text('Open settings'),
              onPressed: () {
                openAppSettings();
                // Get.back();
              },
            ),
          ],
        ),
      );
    }
  }

  void navigateToImageDetail(
    String imagePath,
  ) {
    Get.to(
        fullscreenDialog: true,
        () => Dialog.fullscreen(
              child: SafeArea(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Center(
                      child: Image.file(File(imagePath)),
                    ),
                    Positioned(
                      right: 10,
                      top: 10,
                      child: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Get.back(),
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}
