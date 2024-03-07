import 'package:flutter/material.dart';

import 'package:furniture_store/common/widgets/headings/section_heading.dart';
import 'package:furniture_store/common/widgets/images/circular_image.dart';
import 'package:furniture_store/common/widgets/shimmer/shimmer_loader.dart';
import 'package:furniture_store/features/gallery/screens/all_galleries/all_galleries_screen.dart';
import 'package:furniture_store/features/home/controllers/vendor/vendor_controller.dart';
import 'package:furniture_store/utils/constants/sizes.dart';
import 'package:get/get.dart';

class BuildTopGalleriesSection extends StatelessWidget {
  const BuildTopGalleriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final vendorsController = Get.put(VendorController());

    return Column(
      children: [
        SectionHeading(
          title: 'topGalleries'.tr,
          onPress: () => Get.to(
            () => const AllGalleriesPage(),
            duration: const Duration(milliseconds: 300),
            transition: Transition.rightToLeft,
          ),
        ),
        SizedBox(
          height: 100,
          child: Obx(() {
            if (vendorsController.isLoading.value) {
              return const ShimmerLoaderEffect(
                width: 80,
                height: 80,
                raduis: 10,
              );
            }
            if (vendorsController.featuredVendors.isEmpty) {
              return const Center(child: Text('No Data Found'));
            }
            return ListView.separated(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: vendorsController.featuredVendors.length,
              itemBuilder: (_, index) {
                return Column(
                  children: [
                    CircularImage(
                      imageUrl: vendorsController.featuredVendors[index].image,
                      isNetworkImage: true,
                      width: 80,
                      height: 80,
                    ),
                    Text(vendorsController.featuredVendors[index].name,
                        style: Theme.of(context).textTheme.bodyMedium),
                  ],
                );
              },
              separatorBuilder: (_, __) => SizedBox(
                width: TSizes.spaceBtwItems * 2,
              ),
            );
          }),
        ),
        SizedBox(
          height: TSizes.spaceBtwSections,
        ),
      ],
    );
  }
}
