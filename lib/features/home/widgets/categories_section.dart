import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:decordash/common/widgets/headings/section_heading.dart';
import 'package:decordash/common/widgets/shimmer/category_shimmer.dart';
import 'package:decordash/features/home/controllers/category_controller.dart';
import 'package:decordash/features/home/screens/sub_category/sub_category.dart';
import 'package:decordash/features/home/widgets/horizontal_category.dart';
import 'package:decordash/utils/constants/sizes.dart';
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
        SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        Obx(() {
          if (categoryController.isLoading.value) {
            return CategoryShimmer(
              itemCount: categoryController.featuredCatedories.length,
            );
          }
          if (categoryController.featuredCatedories.isEmpty) {
            return const Center(child: Text('No Categories Found'));
          } else {
            return SizedBox(
              height: 50.h,
              child: ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (_, __) => SizedBox(
                  width: TSizes.spaceBtwItems,
                ),
                scrollDirection: Axis.horizontal,
                itemCount: categoryController.featuredCatedories.length,
                itemBuilder: (context, index) {
                  final category = categoryController.featuredCatedories[index];
                  return HorizontalCategory(
                      onTap: () => Get.to(
                            () => const SubCategoryScreen(),
                            duration: const Duration(milliseconds: 300),
                            transition: Transition.rightToLeft,
                          ),
                      category: category);
                },
              ),
            );
          }
        }),
        SizedBox(
          height: TSizes.spaceBtwSections,
        ),
      ],
    );
  }
}
