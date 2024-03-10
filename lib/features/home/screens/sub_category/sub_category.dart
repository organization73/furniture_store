import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:decordash/common/widgets/headings/section_heading.dart';
import 'package:decordash/common/widgets/images/rounded_image.dart';
import 'package:decordash/common/widgets/products/product_cards/product_card_horizontal.dart';
import 'package:decordash/data/dummy_data.dart';
import 'package:decordash/utils/constants/image_strings.dart';
import 'package:decordash/utils/constants/sizes.dart';

class SubCategoryScreen extends StatelessWidget {
  const SubCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('data'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: TSizes.pagePaddingSpace),
          child: Column(
            children: [
              RoundedImage(
                width: double.infinity,
                height: 170.h,
                imageUrl: TImages.promoBanner1,
              ),
              SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              Column(
                children: [
                  SectionHeading(
                    title: 'Sports Shirts',
                    onPress: () {},
                  ),
                  SizedBox(
                    height: TSizes.spaceBtwItems / 2,
                  ),
                  SizedBox(
                    height: 125.h,
                    child: ListView.separated(
                      itemCount: 4,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_, int index) {
                        return ProductCardHorizontal(
                          product: DummyData.products[0],
                        );
                      },
                      separatorBuilder: (_, __) => SizedBox(
                        width: TSizes.spaceBtwItems,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
