import 'package:decordashapp/common/widgets/images/rounded_image.dart';
import 'package:decordashapp/common/widgets/shimmer/shimmer_loader.dart';
import 'package:decordashapp/modules/home/controllers/carousel_slider_controller.dart';
import 'package:decordashapp/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BannerSlider extends StatelessWidget {
  const BannerSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerController());

    return ConstrainedBox(
      constraints: BoxConstraints(
          maxHeight: TDeviceUtils.getScreenHeight(context) * 0.13),
      child: Obx(() {
        if (controller.isLoading.value) {
          return ShimmerLoaderEffect(
              width: double.infinity,
              height: TDeviceUtils.getScreenHeight(context) * 0.13);
        }
        if (controller.banners.isEmpty) {
          return Center(child: Text('noData'.tr));
        }
        return CarouselView(
          onTap: (value) {
            Get.toNamed(controller.banners[value].targetScreen);
          },
          itemExtent: TDeviceUtils.getScreenWidth(context),
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
    );
  }
}
