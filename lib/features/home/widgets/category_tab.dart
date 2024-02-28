import 'package:flutter/cupertino.dart';
import 'package:furniture_store/common/widgets/galleries/gallery_showcase.dart';
import 'package:furniture_store/common/widgets/headings/section_heading.dart';
import 'package:furniture_store/common/widgets/layouts/grid_layout.dart';
import 'package:furniture_store/common/widgets/products/product_card_vertical.dart';
import 'package:furniture_store/utils/constants/image_strings.dart';
import 'package:furniture_store/utils/constants/sizes.dart';

class CategoryTab extends StatelessWidget {
  const CategoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
          child: Column(
            children: [
              const GelleryShowCase(
                images: [
                  TImages.productImage1,
                  TImages.productImage1,
                  TImages.productImage1
                ],
              ),
              const SectionHeading(
                title: 'You might like',
              ),
              GridLayout(
                  itemCount: 4,
                  itemBuilder: (_, index) {
                    return const ProductCardVerical();
                  }),
              SizedBox(
                height: TSizes.spaceBtwItems,
              ),
            ],
          ),
        )
      ],
    );
  }
}
