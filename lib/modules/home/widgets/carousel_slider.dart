import 'package:decordashapp/common/widgets/images/rounded_image.dart';
import 'package:decordashapp/common/widgets/shimmer/shimmer_loader.dart';
import 'package:decordashapp/modules/home/controllers/carousel_slider_controller.dart';
import 'package:decordashapp/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CarouselSlider extends StatelessWidget {
  const CarouselSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomeCarouselSliderController());

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 110),
        child: Obx(() {
          if (controller.isLoading.value) {
            return const ShimmerLoaderEffect(
                width: double.infinity, height: 110);
          }
          if (controller.banners.isEmpty) {
            return Center(child: Text('noData'.tr));
          }
          return CarouselView(
            itemExtent: TDeviceUtils.getScreenWidth(),
            itemSnapping: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            children: controller.banners.map((item) {
              return Builder(
                builder: (BuildContext context) {
                  return RoundedImage(
                    imageUrl: item.image,
                    isNetworkImage: true,
                    fit: BoxFit.fill,
                  );
                },
              );
            }).toList(),
          );
        }),
      ),
    );
  }
}
