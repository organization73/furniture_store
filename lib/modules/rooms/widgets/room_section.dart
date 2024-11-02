import 'package:decordashapp/common/widgets/headings/section_heading.dart';
import 'package:decordashapp/common/widgets/shimmer/shimmer_loader.dart';
import 'package:decordashapp/modules/home/controllers/category_controller.dart';
import 'package:decordashapp/modules/home/widgets/vertical_category.dart';
import 'package:decordashapp/utils/constants/sizes.dart';
import 'package:decordashapp/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
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
        const SizedBox(
          height: TSizes.spaceBtwSections / 2,
        ),
        Obx(() {
          if (controller.isLoading.value) {
            return ShimmerLoaderEffect(
              width: TDeviceUtils.getScreenWidth(context),
              height: TDeviceUtils.getScreenHeight(context) * 0.18,
              raduis: TSizes.md,
            );
          }
          if (controller.allRooms.isEmpty) {
            return Center(child: Text('noCategories'.tr));
          } else {
            return SizedBox(
              height: TDeviceUtils.getScreenHeight(context) * 0.18,
              child: ListView.builder(
                itemExtent: TDeviceUtils.getScreenWidth(context) * 0.27,
                scrollDirection: Axis.horizontal,
                itemCount: controller.allRooms.length,
                itemBuilder: (context, index) {
                  final room = controller.allRooms[index];
                  return RoomCategoryCard(room: room);
                },
              ),
            );
          }
        }),
      ],
    );
  }
}
