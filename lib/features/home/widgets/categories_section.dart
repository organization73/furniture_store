import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furniture_store/common/widgets/images/circular_image.dart';
import 'package:furniture_store/common/widgets/shimmer/category_shimmer.dart';
import 'package:furniture_store/common/widgets/shimmer/shimmerLoader.dart';
import 'package:furniture_store/features/home/controllers/category_controller.dart';
import 'package:furniture_store/features/home/model/category_model.dart';
import 'package:furniture_store/features/home/screens/categories_screen.dart';
import 'package:furniture_store/utils/constants/image_strings.dart';
import 'package:furniture_store/utils/constants/sizes.dart';

import 'package:get/get.dart';

class BuildCategoriesSection extends StatelessWidget {
  const BuildCategoriesSection({super.key});

  Widget _buildItem(CategoryModel item, BuildContext context) {
    return GestureDetector(
        onTap: () => Get.to(
              () => CategoriesPage(categoryName: item.name),
              duration: const Duration(milliseconds: 300),
              transition: Transition.rightToLeft,
            ),
        child: CircularImage(
          imageUrl: item.image,
          width: 125,
          height: 56,
        )

        // Container(
        //   width: 125,
        //   height: 56,
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(8.0),
        //     image: DecorationImage(
        //       image: CachedNetworkImageProvider(
        //         item.image,
        //       ),
        //       fit: BoxFit.cover,
        //     ),
        //   ),
        //   padding: const EdgeInsets.all(8.0),
        //   margin: const EdgeInsets.only(right: 10),
        //   child: Text(item.name,
        //       textAlign: TextAlign.left,
        //       style: Theme.of(context)
        //           .textTheme
        //           .bodyMedium
        //           ?.copyWith(color: Colors.black)),
        // ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: TSizes.spaceBtwSections,
        ),
        Text(
          'categories'.tr,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        SizedBox(
          height: 15.h,
        ),
        Obx(() {
          if (categoryController.isLoading.value) {
            return const CategoryShimmer();
          }
          if (categoryController.featuredCatedories.isEmpty) {
            return const Text('no date found');
          }
          return SizedBox(
            height: 56,
            child: ListView.builder(
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
