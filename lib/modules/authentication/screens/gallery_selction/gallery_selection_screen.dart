import 'package:flutter/material.dart';
import 'package:decordashapp/common/widgets/buttons/cta_button.dart';
import 'package:decordashapp/common/widgets/headings/page_header.dart';
import 'package:decordashapp/modules/authentication/controllers/gallery_selection/gallery_selection_controller.dart';
import 'package:decordashapp/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class GallerySelectionScreen extends StatelessWidget {
  const GallerySelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GallerySelectionController());

    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: BuildCTAButton(
          text: 'cont'.tr,
          onPressed: controller.navigateToNextScreen,
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: TSizes.pagePaddingSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                PageHeader(
                    title: 'gallarySelect'.tr,
                    subTitle: 'gallarySelectDesc'.tr,
                    iconName: IconsaxPlusLinear.building),
                Obx(() => Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(TSizes.buttonRadius),
                        border: Border.all(
                          color: controller.isGallerySelected.value
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.outlineVariant,
                        ),
                      ),
                      child: InkWell(
                        onTap: () => controller.isGallerySelected.value = true,
                        child: ListTile(
                          title: Text('yesMes'.tr,
                              style: Theme.of(context).textTheme.bodyMedium),
                          leading: Radio(
                            value: true,
                            groupValue: controller.isGallerySelected.value,
                            onChanged: (value) =>
                                controller.isGallerySelected.value = value!,
                          ),
                        ),
                      ),
                    )),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                Obx(() => Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(TSizes.buttonRadius),
                        border: Border.all(
                          color: !controller.isGallerySelected.value
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.outlineVariant,
                        ),
                      ),
                      child: InkWell(
                        onTap: () => controller.isGallerySelected.value = false,
                        child: ListTile(
                          title: Text('noMes'.tr,
                              style: Theme.of(context).textTheme.bodyMedium),
                          leading: Radio(
                            value: false,
                            groupValue: controller.isGallerySelected.value,
                            onChanged: (value) =>
                                controller.isGallerySelected.value = value!,
                          ),
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
