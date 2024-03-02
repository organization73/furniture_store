import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furniture_store/features/home/screens/categories_screen.dart';
import 'package:furniture_store/utils/constants/image_strings.dart';
import 'package:furniture_store/utils/constants/sizes.dart';

import 'package:get/get.dart';

class Category {
  final String name;
  final String imagePath;

  Category(this.name, this.imagePath);
}

class BuildCategoriesSection extends StatelessWidget {
  const BuildCategoriesSection({super.key});

  Widget _buildItem(Category item, BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(
        () => CategoriesPage(categoryName: item.name),
        duration: const Duration(milliseconds: 300),
        transition: Transition.rightToLeft,
      ),
      child: Container(
        width: 125,
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          image: DecorationImage(
            image: AssetImage(item.imagePath),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.only(right: 10),
        child: Text(item.name,
            textAlign: TextAlign.left,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.black)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Category> items = [
      Category('chairsCartegory'.tr, TImages.chairsCategory),
      Category('sofaCartegory'.tr, TImages.sofasCategory),
      Category('desksCartegory'.tr, TImages.desksCategory),
    ];
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
        SizedBox(
          height: 56,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (context, index) {
              return _buildItem(items[index], context);
            },
          ),
        ),
        SizedBox(
          height: TSizes.spaceBtwSections,
        ),
      ],
    );
  }
}
