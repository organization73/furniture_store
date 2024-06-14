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
              height: 160.h,
              child: ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (_, __) => SizedBox(
                  width: TSizes.spaceBtwItems,
                ),
                scrollDirection: Axis.horizontal,
                itemCount: controller.roomsCatedories.length,
                itemBuilder: (context, index) {
                  final category = controller.roomsCatedories[index];
                  return VerticalCategory(
                      onTap: () => Get.to(
                            () => SubCategoryScreen(
                              category: category,
                            ),
                            duration: const Duration(milliseconds: 300),
                            transition: Transition.rightToLeft,
                          ),
                      category: category);
                },
              ),
            );
          }
        }),
      ],
    );
  }
}

  //  SingleChildScrollView(
  //         padding: const EdgeInsets.symmetric(
  //           vertical: 10,
  //         ),
  //         scrollDirection: Axis.horizontal,
  //         child: Row(
  //           children: listIteams.entries.map((entry) {
  //             var sectionName = entry.key;
  //             var image = entry.value;

  //             return InkWell(
  //               onTap: () => Get.to(
  //                 () => CategoriesPage(
  //                     categoryName: lang == 'ar'
  //                         ? 'غرف $sectionName'
  //                         : '$sectionName Room'),
  //                 duration: const Duration(milliseconds: 300),
  //                 transition: Transition.rightToLeft,
  //               ),
  //               child: Container(
  //                 width: 130,
  //                 height: 195,
  //                 decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(8.0),
  //                   image: DecorationImage(
  //                     image: AssetImage(image),
  //                     fit: BoxFit.cover,
  //                   ),
  //                 ),
  //                 padding:
  //                     const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
  //                 margin: const EdgeInsets.symmetric(horizontal: 8),
  //                 child: Row(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     lang == 'ar'
  //                         ? Text('غرف\n$sectionName',
  //                             style: Theme.of(context)
  //                                 .textTheme
  //                                 .bodyMedium
  //                                 ?.copyWith(color: Colors.black))
  //                         : Text('$sectionName\nRoom',
  //                             style: Theme.of(context)
  //                                 .textTheme
  //                                 .bodyMedium
  //                                 ?.copyWith(color: Colors.black)),
  //                   ],
  //                 ),
  //               ),
  //             );
  //           }).toList(),
  //         ),
  //       )