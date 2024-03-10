import 'dart:io';
import 'package:flutter/material.dart';
import 'package:decordash/common/widgets/build_user_input_field.dart';
import 'package:decordash/common/widgets/cta_button.dart';
import 'package:decordash/common/widgets/headings/page_header.dart';
import 'package:decordash/features/authentication/controllers/gallery_info/gallery_information_controller.dart';
import 'package:decordash/features/authentication/model/gallery_info/gallery_information_model.dart';
import 'package:decordash/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:image_picker/image_picker.dart';

class GalleryInformationScreen extends StatelessWidget {
  final GalleryInformationModel model = Get.put(GalleryInformationModel());
  final GalleryInformationController controller =
      GalleryInformationController.getInstance();

  GalleryInformationScreen({super.key});

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      model.updateSelectedImage(File(pickedFile.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        height: 70,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: BuildCTAButton(
          text: 'cont'.tr,
          onPressed: controller.validateAndSubmit,
        ),
      ),
      appBar: AppBar(),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: TSizes.pagePaddingSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  PageHeader(
                      title: 'gallaryTitle'.tr,
                      subTitle: 'gallaryTitleDesc'.tr,
                      iconName: Iconsax.shop),
                  RoundedTextField(
                    'galleryName'.tr,
                    controller.galleryNameController,
                    prefixIcon: Iconsax.user_octagon,
                    keyboardType: TextInputType.name,
                    (value) =>
                        value == null || value.isEmpty || value.length <= 4
                            ? 'galleryVallen'.tr
                            : null,
                  ),
                  SizedBox(height: TSizes.spaceBtwInputFields),
                  RoundedTextField(
                    'galleryAddress'.tr,
                    controller.galleryAddressController,
                    prefixIcon: Iconsax.location,
                    keyboardType: TextInputType.name,
                    (value) =>
                        value == null || value.isEmpty || value.length <= 6
                            ? 'galleryAddressVal'.tr
                            : null,
                  ),
                  SizedBox(height: TSizes.spaceBtwSections),
                  OutlinedButton.icon(
                    onPressed: _pickImage,
                    icon: const Icon(Iconsax.additem),
                    label: Text(
                      'uploadGalleryID'.tr,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                  Obx(() => model.selectedImage.value != null
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          child: Text(
                            '${'selectedFile'.tr}: ${model.selectedImage.value!.path.split('/').last}',
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        )
                      : const SizedBox.shrink()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
