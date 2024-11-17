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
                  iconName: IconsaxPlusLinear.building,
                ),
                _buildSelectionOption(
                  context,
                  controller,
                  isSelected: true,
                  title: 'yesMes'.tr,
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                _buildSelectionOption(
                  context,
                  controller,
                  isSelected: false,
                  title: 'noMes'.tr,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSelectionOption(
    BuildContext context,
    GallerySelectionController controller, {
    required bool isSelected,
    required String title,
  }) {
    return GetBuilder<GallerySelectionController>(
      builder: (controller) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(TSizes.buttonRadius),
          border: Border.all(
            color: controller.isGallerySelected == isSelected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.outlineVariant,
          ),
        ),
        child: InkWell(
          onTap: () => controller.setGallerySelected(isSelected),
          child: ListTile(
            title: Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            leading: Radio(
              value: isSelected,
              groupValue: controller.isGallerySelected,
              onChanged: (value) => controller.setGallerySelected(value!),
            ),
          ),
        ),
      ),
    );
  }
}
