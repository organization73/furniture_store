import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:furniture_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:furniture_store/common/widgets/images/rounded_image.dart';
import 'package:furniture_store/features/home/controllers/home_controller.dart';
import 'package:furniture_store/utils/constants/sizes.dart';
import 'package:get/get.dart';

class ImageSlider extends StatelessWidget {
  const ImageSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    final List<String> imagesWithContent = [
      'https://assets.materialup.com/uploads/09b18322-202a-4acc-9706-84a91e3771e1/attachment.jpg',
      'https://t4.ftcdn.net/jpg/04/66/25/33/360_F_466253361_c4fAjCqVZD4L2boH8vfqjUbUYk0wLcP7.jpg',
      'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/furniture-banner-template-design-a636dbc0cd8fcad1e4f5c65dc3746501_screen.jpg?ts=1609919679',
    ];
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            aspectRatio: 3 / 1.5,
            autoPlay: true,
            viewportFraction: 1,
            autoPlayInterval: const Duration(seconds: 5),
            onPageChanged: (index, _) => controller.updatePageIndicator(index),
          ),
          items: imagesWithContent.map((item) {
            return Builder(
              builder: (BuildContext context) {
                return RoundedImage(
                  imageUrl: item,
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
              children: imagesWithContent.map((item) {
                int index = imagesWithContent.indexOf(item);
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
  }
}
