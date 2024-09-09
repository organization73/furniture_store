import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:decordashapp/common/widgets/headings/section_heading.dart';
import 'package:decordashapp/common/widgets/shimmer/category_shimmer.dart';
import 'package:decordashapp/features/home/controllers/category_controller.dart';
import 'package:decordashapp/features/home/screens/sub_category/sub_category.dart';
import 'package:decordashapp/features/home/widgets/horizontal_category.dart';
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
            return CategoryShimmer(
              itemCount: categoryController.featuredCatedories.length,
            );
          }
          if (categoryController.featuredCatedories.isEmpty) {
            return Center(child: Text('noCategories'.tr));
          } else {
            return SizedBox(
              height: 50.h,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: categoryController.featuredCatedories.length,
                itemBuilder: (context, index) {
                  final category = categoryController.featuredCatedories[index];

                  return Padding(
                    padding: const EdgeInsets.only(right: TSizes.spaceBtwItems),
                    child: HorizontalCategory(
                      onTap: () => Get.to(
                        () => SubCategoryScreen(
                          category: category,
                        ),
                        duration: const Duration(milliseconds: 300),
                        transition: Transition.rightToLeft,
                      ),
                      category: category,
                    ),
                  );
                },
              ),
            );
          }
        }),
        const SizedBox(
          height: TSizes.spaceBtwSections,
        ),
      ],
    );
  }
}
