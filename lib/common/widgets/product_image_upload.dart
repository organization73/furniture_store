import 'dart:io';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furniture_store/utils/constants/colors.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class BuildProductImageUpload extends StatefulWidget {
  final List<String> pickedImagePaths;

  const BuildProductImageUpload({super.key, required this.pickedImagePaths});

  @override
  State<BuildProductImageUpload> createState() =>
      _BuildProductImageUploadState();
}

class _BuildProductImageUploadState extends State<BuildProductImageUpload> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  Future<void> _pickImagesFromGallery() async {
    final ImagePicker picker = ImagePicker();
    try {
      // Pick multiple images from the gallery
      final List<XFile> pickedFiles = await picker.pickMultiImage();

      if (pickedFiles.isNotEmpty) {
        // Add the picked image paths to the list and update the UI
        setState(() {
          widget.pickedImagePaths.addAll(pickedFiles.map((file) => file.path));
        });
      }
    } catch (e) {
      // Show a SnackBar with the error message
      _scaffoldKey.currentState?.showSnackBar(
        SnackBar(
          content: Text('Error taking photo: $e'),
        ),
      );
    }
  }

  Future<void> _takePhoto() async {
    final ImagePicker picker = ImagePicker();

    // Check if camera permissions are granted
    PermissionStatus status = await Permission.camera.status;
    if (status.isGranted) {
      try {
        // Take a photo using the camera
        final XFile? takenPhoto =
            await picker.pickImage(source: ImageSource.camera);

        if (takenPhoto != null) {
          // Add the taken photo path to the list and update the UI
          setState(() {
            widget.pickedImagePaths.add(takenPhoto.path);
          });
        }
      } catch (e) {
        // Show a SnackBar with the error message
        _scaffoldKey.currentState?.showSnackBar(
          SnackBar(
            content: Text('Error taking photo: $e'),
          ),
        );
      }
    } else {
      // If permissions are not granted, show a dialog to request them
      showAlertDialog();
    }
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

  void _deleteImage(int index) {
    setState(() {
      widget.pickedImagePaths.removeAt(index);
    });
  }

  void _navigateToImageDetail(String imagePath, int index) {
    String heroTag = 'imageHero_$index';
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          return ImageDetailScreen(imagePath: imagePath, heroTag: heroTag);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: _pickImagesFromGallery,
          child: Container(
            width: double.infinity,
            height: 100.h,
            decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                border: Border.all(
                  color: TColors.darkGrey,
                  width: 0.5,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(32))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Iconsax.picture_frame,
                  size: 50,
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
                Text(
                  'fileUpload'.tr,
                  style: Theme.of(context).textTheme.labelSmall,
                )
              ],
            ),
          ),
        ),
        const Divider(
          indent: 20,
          endIndent: 20,
          height: 30,
        ),
        FilledButton.tonalIcon(
            onPressed: _takePhoto,
            icon: Icon(
              Iconsax.camera,
              color: Theme.of(context).colorScheme.primary,
            ),
            label: Text(
              'openCam'.tr,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Theme.of(context).colorScheme.primary),
            )),
        SizedBox(
          height: 10.h,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: widget.pickedImagePaths.asMap().entries.map((entry) {
              final int index = entry.key;
              final String path = entry.value;

              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        _navigateToImageDetail(path, index);
                      },
                      child: Hero(
                        tag: 'imageHero_$index',
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: Image.file(
                            File(path),
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: const ShapeDecoration(
                        gradient: LinearGradient(colors: [
                          Color.fromARGB(255, 202, 56, 56),
                          Color.fromARGB(255, 217, 40, 72)
                        ]),
                        shape: CircleBorder(
                            side: BorderSide(color: Colors.transparent)),
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        splashRadius: 35 / 2,
                        iconSize: 35 / 2,
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                        onPressed: () => _deleteImage(index),
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class ImageDetailScreen extends StatelessWidget {
  final String imagePath;
  final String heroTag;

  const ImageDetailScreen(
      {super.key, required this.imagePath, required this.heroTag});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.7),
      body: Stack(
        children: [
          Center(
            child: Hero(
              tag: heroTag,
              child: Image.file(File(imagePath)),
            ),
          ),
          Positioned(
            top: 30,
            right: 10,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
