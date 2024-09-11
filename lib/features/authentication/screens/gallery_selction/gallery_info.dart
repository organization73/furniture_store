import 'package:decordashapp/features/personalization/controllers/user/user_controller.dart';
import 'package:decordashapp/utils/device/device_utility.dart';
import 'package:decordashapp/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:decordashapp/common/widgets/input_fields/build_user_input_field.dart';
import 'package:decordashapp/common/widgets/buttons/cta_button.dart';
import 'package:decordashapp/common/widgets/headings/page_header.dart';
import 'package:decordashapp/features/authentication/controllers/gallery_info/gallery_information_controller.dart';
import 'package:decordashapp/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class GalleryInformationScreen extends StatelessWidget {
  final controller = Get.put(GalleryInfoController());

  GalleryInformationScreen({super.key});

  final userController = UserController.instance;

  @override
  Widget build(BuildContext context) {
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
                    prefixIcon: Iconsax.user_octagon_copy,
                    keyboardType: TextInputType.name,
                    TValidator.validateGalleryName,
                  ),
                  const SizedBox(height: TSizes.spaceBtwInputFields),
                  RoundedTextField(
                    'galleryAddress'.tr,
                    controller.galleryAddressController,
                    prefixIcon: Iconsax.location_copy,
                    keyboardType: TextInputType.name,
                    TValidator.validateGalleryLoc,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  const Divider(),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          //TODO Add upload gallery picture function
                          onTap: () {},
                          child: Container(
                            width: double.infinity,
                            height: TDeviceUtils.getScreenHeight() * 0.12,
                            decoration: BoxDecoration(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                border: Border.all(
                                  width: 0.5,
                                ),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(15))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Iconsax.picture_frame,
                                  size: 50,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                ),
                                Text(
                                  'Upload gallery picture',
                                  style: Theme.of(context).textTheme.labelSmall,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: TSizes.sm),
                      Expanded(
                        child: GestureDetector(
                          onTap: () =>
                              userController.uploadGalleryCertificate(),
                          child: Container(
                            width: double.infinity,
                            height: TDeviceUtils.getScreenHeight() * 0.12,
                            decoration: BoxDecoration(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                border: Border.all(
                                  width: 0.5,
                                ),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(15))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Iconsax.additem_copy,
                                  size: 50,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                ),
                                Text(
                                  'uploadGalleryID'.tr,
                                  style: Theme.of(context).textTheme.labelSmall,
                                )
                              ],
                            ),
                          ),
                        ),
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
