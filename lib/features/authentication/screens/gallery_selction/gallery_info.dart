import 'dart:io';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furniture_store/common/widgets/build_user_input_field.dart';
import 'package:furniture_store/common/widgets/cta_button.dart';
import 'package:furniture_store/common/widgets/text_header.dart';
import 'package:furniture_store/features/authentication/controllers/gallery_info/gallery_information_controller.dart';
import 'package:furniture_store/features/authentication/model/gallery_info/gallery_information_model.dart';
import 'package:furniture_store/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';

class GalleryInformationScreen extends StatelessWidget {
 final GalleryInformationModel model = Get.put(GalleryInformationModel());
 final GalleryInformationController controller = GalleryInformationController.getInstance();


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
        height: 68,
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
              padding: const EdgeInsets.all(TSizes.pagePaddingSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  BuildTopText(
                      title: 'gallaryTitle'.tr,
                      subTitle: 'gallaryTitleDesc'.tr,
                      iconName: 'email'),
                  SizedBox(height: 20.h),
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
                  SizedBox(height: TSizes.spaceBtwInputFields),
                  InkWell(
                    onTap: _pickImage,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: ListTile(
                        leading: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Icon(Icons.attachment_rounded),
                        ),
                        title: Text(
                          'uploadGalleryID'.tr,
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ),
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
