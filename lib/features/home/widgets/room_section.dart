import 'package:decordash/common/widgets/headings/section_heading.dart';
import 'package:decordash/common/widgets/shimmer/category_shimmer.dart';
import 'package:decordash/features/home/controllers/category_controller.dart';
import 'package:decordash/features/home/screens/sub_category/sub_category.dart';
import 'package:decordash/features/home/widgets/vertical_category.dart';
import 'package:decordash/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BuildRoomsSection extends StatelessWidget {
  const BuildRoomsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeading(
          title: 'roomsSec'.tr,
          subTitle: 'roomsSecDesc'.tr,
          showSubTitle: true,
          showActionButton: false,
        ),
        SizedBox(
          height: TSizes.spaceBtwSections / 2,
        ),
        Obx(() {
          if (controller.isLoading.value) {
            return CategoryShimmer(
              itemCount: controller.roomsCatedories.length,
            );
          }
          if (controller.roomsCatedories.isEmpty) {
            return Center(child: Text('noCategories'.tr));
          } else {
            return SizedBox(
              height: 150.h,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: controller.roomsCatedories.length,
                itemBuilder: (context, index) {
                  final category = controller.roomsCatedories[index];
                  return Padding(
                    padding: EdgeInsets.only(right: TSizes.spaceBtwItems),
                    child: VerticalCategory(
                        onTap: () => Get.to(
                              () => SubCategoryScreen(
                                category: category,
                              ),
                              duration: const Duration(milliseconds: 300),
                              transition: Transition.rightToLeft,
                            ),
                        category: category),
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
