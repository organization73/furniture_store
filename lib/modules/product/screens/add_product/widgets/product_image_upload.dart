import 'dart:io';
import 'package:decordashapp/modules/product/screens/add_product/controllers/add_product_controller.dart';
import 'package:decordashapp/modules/product/screens/add_product/controllers/upload_image_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class BuildProductImageUpload extends StatelessWidget {
  const BuildProductImageUpload({super.key});

  @override
  Widget build(BuildContext context) {
    final imageUploadController = Get.put(UploadImageFromGalleryController());
    return Column(
      children: [
        GestureDetector(
          onTap: imageUploadController.pickImagesFromGallery,
          child: Container(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                border: Border.all(
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
            onPressed: imageUploadController.takePhoto,
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
        const SizedBox(
          height: 10,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Obx(() => Row(
                children: AddProductController.instance.pickedImagePaths
                    .asMap()
                    .entries
                    .map((entry) {
                  final int index = entry.key;
                  final String path = entry.value;

                  return Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            imageUploadController.navigateToImageDetail(
                              path,
                            );
                          },
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
                            onPressed: () =>
                                imageUploadController.deleteImage(index),
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              )),
        ),
      ],
    );
  }
}
