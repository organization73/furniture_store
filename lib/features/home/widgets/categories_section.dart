import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furniture_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:furniture_store/common/widgets/headings/section_heading.dart';
import 'package:furniture_store/common/widgets/images/rounded_image.dart';
import 'package:furniture_store/common/widgets/shimmer/category_shimmer.dart';
import 'package:furniture_store/features/home/controllers/category_controller.dart';
import 'package:furniture_store/features/home/model/category_model.dart';
import 'package:furniture_store/features/home/screens/sub_category/sub_category.dart';
import 'package:furniture_store/utils/constants/colors.dart';
import 'package:furniture_store/utils/constants/image_strings.dart';
import 'package:furniture_store/utils/constants/sizes.dart';

import 'package:get/get.dart';

class BuildCategoriesSection extends StatelessWidget {
  const BuildCategoriesSection({super.key});

  Widget _buildItem(CategoryModel item, BuildContext context) {
    return GestureDetector(
        onTap: () => Get.to(
              () => const SubCategoryScreen(),
              duration: const Duration(milliseconds: 300),
              transition: Transition.rightToLeft,
            ),
        child: RoundedContainer(
          width: 125.w,
          hight: 56.h,
          backgroundColor: TColors.grey.withOpacity(0.7),
          child: Stack(
            children: [
              const Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: RoundedImage(
                    imageUrl: TImages.shoeIcon,
                    // isNetworkImage: true,

                    borderRaduis: 8,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    item.name,
                    textAlign: TextAlign.left,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        )
        // Stack(
        //   children: [
        //     RoundedImage(
        //       imageUrl: item.image,
        //       isNetworkImage: true,
        //       width: 125.w,
        //       height: 56.h,
        //       borderRaduis: 8,
        //       backgroundColor: Colors.amber,
        //     ),
        //     Align(
        //       alignment: Alignment.topLeft,
        //       child: Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: Text(
        //           item.name,
        //           textAlign: TextAlign.left,
        //           style: Theme.of(context)
        //               .textTheme
        //               .bodyMedium
        //               ?.copyWith(color: Colors.black),
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final categoryController = CategoryController.instance;

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
          }
          return SizedBox(
            height: 56.h,
            child: ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (_, __) => SizedBox(
                width: TSizes.spaceBtwItems,
              ),
              scrollDirection: Axis.horizontal,
              itemCount: categoryController.featuredCatedories.length,
              itemBuilder: (context, index) {
                final category = categoryController.featuredCatedories[index];
                return _buildItem(category, context);
              },
            ),
          );
        }),
        SizedBox(
          height: TSizes.spaceBtwSections,
        ),
      ],
    );
  }
}
