import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furniture_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:furniture_store/common/widgets/images/rounded_image.dart';
import 'package:furniture_store/common/widgets/shimmer/shimmer_loader.dart';
import 'package:furniture_store/features/home/controllers/carousel_slider_controller.dart';
import 'package:furniture_store/utils/constants/sizes.dart';
import 'package:get/get.dart';

class ImageSlider extends StatelessWidget {
  const ImageSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CarouselSliderController());

    return Obx(() {
      if (controller.isLoading.value) {
        return const ShimmerLoaderEffect(width: double.infinity, height: 150);
      }
      if (controller.banners.isEmpty) {
        return const Center(child: Text('No Data Found'));
      }
      return Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              aspectRatio: 3 / 1.5,
              autoPlay: true,
              viewportFraction: 1,
              autoPlayInterval: const Duration(seconds: 5),
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
            height: TSizes.spaceBtwSections,
          ),
          Obx(() => Row(
                mainAxisSize: MainAxisSize.min,
                children: controller.banners.map((item) {
                  int index = controller.banners.indexOf(item);
                  return RoundedContainer(
                    hight: 5,
                    width: 5,
                    backgroundColor:
                        controller.carouselCurrentIndex.value == index
                            ? Theme.of(context).colorScheme.primary
                            : Colors.grey,
                    margin: const EdgeInsets.only(right: 10),
                  );
                }).toList(),
              ))
        ],
      );
    });
  }
}
