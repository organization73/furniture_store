import 'package:decordashapp/modules/authentication/widgets/upload_gallery_info.dart';
import 'package:decordashapp/modules/personalization/controllers/user/user_controller.dart';
import 'package:decordashapp/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:decordashapp/common/widgets/input_fields/build_user_input_field.dart';
import 'package:decordashapp/common/widgets/buttons/cta_button.dart';
import 'package:decordashapp/common/widgets/headings/page_header.dart';
import 'package:decordashapp/modules/authentication/controllers/gallery_info/gallery_information_controller.dart';
import 'package:decordashapp/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class GalleryInformationScreen extends StatelessWidget {
  const GalleryInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GalleryInfoController());

    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: BuildCTAButton(
          text: 'cont'.tr,
          onPressed: controller.validateAndSubmit,
        ),
      ),
      appBar: AppBar(
        forceMaterialTransparency: true,
      ),
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
                      iconName: Iconsax.buildings),
                  RoundedTextField(
                    'galleryName'.tr,
                    controller.galleryNameController,
                    prefixIcon: Iconsax.user_tag_copy,
                    keyboardType: TextInputType.name,
                    TValidator.validateGalleryName,
                  ),
                  const SizedBox(height: TSizes.spaceBtwInputFields),
                  RoundedTextField(
                    'galleryAddress'.tr,
                    showLabel: false,
                    controller.galleryAddressController,
                    prefixIcon: Iconsax.location_copy,
                    suffixIcon: IconButton(
                        onPressed: () {
                          controller.getLocation();
                        },
                        icon: const Icon(
                          Iconsax.map_copy,
                          size: TSizes.iconMd,
                        )),
                    keyboardType: TextInputType.name,
                    TValidator.validateGalleryLoc,
                    isReadonly: true,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Row(
                    children: [
                      UploadGalleryInfo(
                        onTap: () => UserController.instance
                            .uploadGalleryInfo(isCertificate: false),
                        title: 'Upload gallery picture',
                        icon: Iconsax.picture_frame,
                      ),
                      const SizedBox(width: TSizes.sm),
                      UploadGalleryInfo(
                        onTap: () => UserController.instance
                            .uploadGalleryInfo(isCertificate: true),
                        title: 'uploadGalleryID'.tr,
                        icon: Iconsax.card,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
