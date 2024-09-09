import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:decordashapp/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:decordashapp/common/widgets/images/rounded_image.dart';
import 'package:decordashapp/common/widgets/shimmer/shimmer_loader.dart';
import 'package:decordashapp/features/home/controllers/carousel_slider_controller.dart';
import 'package:decordashapp/utils/constants/sizes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ImageSlider extends StatelessWidget {
  const ImageSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomeCarouselSliderController());

    return Obx(() {
      if (controller.isLoading.value) {
        return ShimmerLoaderEffect(width: double.infinity, height: 100.h);
      }
      if (controller.banners.isEmpty) {
        return Center(child: Text('noData'.tr));
      }
      return Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: 100.h,
              viewportFraction: 1,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 10),
              onPageChanged: (index, _) =>
                  controller.updatePageIndicator(index),
            ),
            items: controller.banners.map((item) {
              return Builder(
                builder: (BuildContext context) {
                  return RoundedImage(
                    imageUrl: item.image,
                    isNetworkImage: true,
                  );
                },
              );
            }).toList(),
          ),
          SizedBox(
            height: TSizes.spaceBtwSections / 2,
          ),
          Obx(() => Row(
                mainAxisSize: MainAxisSize.min,
                children: controller.banners.map((item) {
                  int index = controller.banners.indexOf(item);
                  return RoundedContainer(
                    hight: 4.r,
                    width: 4.r,
                    backgroundColor:
                        controller.carouselCurrentIndex.value == index
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.primaryContainer,
                    margin: const EdgeInsets.only(right: 10).w,
                  );
                }).toList(),
              ))
        ],
      );
    });
  }
}
