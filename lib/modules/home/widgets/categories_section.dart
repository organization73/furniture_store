import 'package:decordashapp/common/widgets/shimmer/shimmer_loader.dart';
import 'package:decordashapp/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:decordashapp/common/widgets/headings/section_heading.dart';
import 'package:decordashapp/modules/home/controllers/category_controller.dart';
import 'package:decordashapp/modules/home/screens/sub_category/sub_category_screen.dart';
import 'package:decordashapp/modules/home/widgets/horizontal_category.dart';
import 'package:decordashapp/utils/constants/sizes.dart';
import 'package:get/get.dart';

class BuildCategoriesSection extends StatelessWidget {
  const BuildCategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeading(
          title: 'categories'.tr,
          showActionButton: false,
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        Obx(() {
          if (categoryController.isLoading.value) {
            return ShimmerLoaderEffect(
              width: TDeviceUtils.getScreenWidth(),
              height: TDeviceUtils.getScreenHeight() * 0.07,
              raduis: TSizes.md,
            );
          }
          if (categoryController.allCatedories.isEmpty) {
            return Center(child: Text('noCategories'.tr));
          } else {
            return SizedBox(
              height: TDeviceUtils.getScreenHeight() * 0.07,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categoryController.allCatedories.length,
                itemBuilder: (context, index) {
                  final category = categoryController.allCatedories[index];

                  return HorizontalCategory(
                    onTap: () => Get.to(
                      () => SubCategoryScreen(
                        category: category,
                      ),
                      duration: const Duration(milliseconds: 300),
                      transition: Transition.rightToLeft,
                    ),
                    category: category,
                  );
                },
              ),
            );
          }
        }),
      ],
    );
  }
}
