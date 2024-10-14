import 'package:decordashapp/modules/profile/controllers/update_gallery_info.dart';
import 'package:flutter/material.dart';
import 'package:decordashapp/common/widgets/input_fields/build_user_input_field.dart';
import 'package:decordashapp/common/widgets/buttons/cta_button.dart';
import 'package:decordashapp/utils/constants/sizes.dart';
import 'package:decordashapp/utils/validators/validation.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class ChangeGalleryInfoScreen extends StatelessWidget {
  const ChangeGalleryInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateGalleryController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Gallery Info'),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: BuildCTAButton(
            text: 'tContinue'.tr,
            onPressed: () {
              controller.updateGalleryInfo();
            }),
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.pagePaddingSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
                key: controller.updateGalleryFormKey,
                child: Column(
                  children: [
                    RoundedTextField(
                        'galleryName'.tr,
                        controller.galleryNameController,
                        prefixIcon: IconsaxPlusLinear.user,
                        keyboardType: TextInputType.name,
                        TValidator.validateGalleryName),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
