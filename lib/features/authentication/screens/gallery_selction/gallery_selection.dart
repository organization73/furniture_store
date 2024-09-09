import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:decordashapp/common/widgets/buttons/cta_button.dart';
import 'package:decordashapp/common/widgets/headings/page_header.dart';
import 'package:decordashapp/features/authentication/controllers/gallery_selection/gallery_selection_controller.dart';
import 'package:decordashapp/features/authentication/model/gallery_selection/gallery_selection_model.dart';
import 'package:decordashapp/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class GallerySelection extends StatelessWidget {
  final GallerySelectionModel model = Get.put(GallerySelectionModel());
  final GallerySelectionController controller =
      GallerySelectionController.getInstance();

  GallerySelection({super.key});

  @override
  Widget build(BuildContext context) {
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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: TSizes.pagePaddingSpace),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                PageHeader(
                    title: 'gallarySelect'.tr,
                    subTitle: 'gallarySelectDesc'.tr,
                    iconName: Iconsax.building),
                Obx(() => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0.r),
                        border: Border.all(
                          color: model.selectedOption.value == 1
                              ? Theme.of(context).colorScheme.primary
                              : Colors.grey,
                        ),
                      ),
                      child: InkWell(
                        onTap: () => controller.model.selectOption(1),
                        child: ListTile(
                          title: Text('yesMes'.tr,
                              style: Theme.of(context).textTheme.titleMedium),
                          leading: Radio(
                            value: 1,
                            groupValue: model.selectedOption.value,
                            onChanged: (int? value) =>
                                controller.model.selectOption(value!),
                          ),
                        ),
                      ),
                    )),
                SizedBox(height: TSizes.spaceBtwInputFields),
                Obx(() => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0.r),
                        border: Border.all(
                          color: model.selectedOption.value == 0
                              ? Theme.of(context).colorScheme.primary
                              : Colors.grey,
                        ),
                      ),
                      child: InkWell(
                        onTap: () => controller.model.selectOption(0),
                        child: ListTile(
                          title: Text('noMes'.tr,
                              style: Theme.of(context).textTheme.titleMedium),
                          leading: Radio(
                            value: 0,
                            groupValue: model.selectedOption.value,
                            onChanged: (int? value) =>
                                controller.model.selectOption(value!),
                          ),
                        ),
                      ),
                    )),
                SizedBox(height: TSizes.spaceBtwSections),
                Center(
                  child: SvgPicture.asset(
                    'assets/icons/gallery_loc.svg',
                    width: 160.r,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
