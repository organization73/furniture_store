import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CarouselSliderPage extends StatefulWidget {
  const CarouselSliderPage({super.key});

  @override
  CarouselSliderPageState createState() => CarouselSliderPageState();
}

class CarouselSliderPageState extends State<CarouselSliderPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> imagesWithContent = [
      {
        'image':
            'https://assets.materialup.com/uploads/09b18322-202a-4acc-9706-84a91e3771e1/attachment.jpg',
      },
      {
        'image':
            'https://t4.ftcdn.net/jpg/04/66/25/33/360_F_466253361_c4fAjCqVZD4L2boH8vfqjUbUYk0wLcP7.jpg',
      },
      {
        'image':
            'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/furniture-banner-template-design-a636dbc0cd8fcad1e4f5c65dc3746501_screen.jpg?ts=1609919679',
      },
    ];
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 180.0.h,
            autoPlay: true,
            viewportFraction: 1,
            enlargeCenterPage: true,
            enlargeFactor: 0.3,
            autoPlayInterval: const Duration(seconds: 5),
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          items: imagesWithContent.map((item) {
            return Builder(
              builder: (BuildContext context) {
                return InkWell(
                  onTap: () {},
                  child: Container(
                    width: ScreenUtil().screenWidth,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(item['image']!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imagesWithContent.map((url) {
            int index = imagesWithContent.indexOf(url);
            return Container(
              width: 5.0.w,
              height: 5.0.h,
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentIndex == index
                    ? Theme.of(context).colorScheme.onBackground
                    : Colors.grey,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
