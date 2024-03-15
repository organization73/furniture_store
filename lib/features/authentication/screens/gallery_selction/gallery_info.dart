import 'package:decordash/features/personalization/controllers/user/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:decordash/common/widgets/input_fields/build_user_input_field.dart';
import 'package:decordash/common/widgets/buttons/cta_button.dart';
import 'package:decordash/common/widgets/headings/page_header.dart';
import 'package:decordash/features/authentication/controllers/gallery_info/gallery_information_controller.dart';
import 'package:decordash/utils/constants/sizes.dart';
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
        height: 73,
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
                      iconName: Iconsax.buildings),
                  RoundedTextField(
                    'galleryName'.tr,
                    controller.galleryNameController,
                    prefixIcon: Iconsax.user_octagon_copy,
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
                    prefixIcon: Iconsax.location_copy,
                    keyboardType: TextInputType.name,
                    (value) =>
                        value == null || value.isEmpty || value.length <= 6
                            ? 'galleryAddressVal'.tr
                            : null,
                  ),
                  SizedBox(height: TSizes.spaceBtwSections),
                  OutlinedButton.icon(
                    onPressed: () => userController.uploadGalleryCertificate(),
                    icon: const Icon(Iconsax.additem_copy),
                    label: Text(
                      'uploadGalleryID'.tr,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
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
