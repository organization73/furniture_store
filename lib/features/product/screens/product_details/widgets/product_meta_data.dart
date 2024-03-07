import 'package:flutter/material.dart';
import 'package:furniture_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:furniture_store/common/widgets/headings/section_heading.dart';
import 'package:furniture_store/common/widgets/texts/brand_title_text_with_verified_icon.dart';
import 'package:furniture_store/common/widgets/texts/product_price_text.dart';
import 'package:furniture_store/common/widgets/texts/product_title_text.dart';
import 'package:furniture_store/features/home/model/product_model.dart';
import 'package:furniture_store/features/product/screens/product_reviews/product_review_screen.dart';
import 'package:furniture_store/features/product/screens/product_details/widgets/product_specs.dart';
import 'package:furniture_store/features/product/screens/product_details/widgets/product_status_checkboxes.dart';
import 'package:furniture_store/features/product/screens/product_reviews/widgets/user_review_card.dart';
import 'package:furniture_store/utils/constants/colors.dart';
import 'package:furniture_store/utils/constants/enums.dart';
import 'package:furniture_store/utils/constants/sizes.dart';
import 'package:furniture_store/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';

class ProductMetaData extends StatelessWidget {
  const ProductMetaData({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            RoundedContainer(
              raduis: TSizes.sm,
              backgroundColor: TColors.secondary.withOpacity(0.8),
              padding: const EdgeInsets.symmetric(
                  horizontal: TSizes.sm, vertical: TSizes.xs),
              child: Text(
                '25%',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .apply(color: TColors.black),
              ),
            ),
            SizedBox(
              width: TSizes.spaceBtwItems,
            ),
            Text(
              '250 LE',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .apply(decoration: TextDecoration.lineThrough),
            ),
            SizedBox(
              width: TSizes.spaceBtwItems,
            ),
            const ProductPriceText(
              price: '185',
              isLarge: true,
            ),
          ],
        ),
        SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        const ProductTitleText(title: 'Red bed with wooden pillers'),
        SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        const BrandTitleTextWithVerifiedIcon(
          title: 'Ali',
          beandtextSize: TextSizes.medium,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Iconsax.location,
              color: Theme.of(context).textTheme.labelMedium!.color,
              size: TSizes.iconSm,
            ),
            const SizedBox(
              width: TSizes.xs,
            ),
            Text(
              'Damietta',
              style: Theme.of(context).textTheme.labelMedium,
            )
          ],
        ),
        SizedBox(
          height: TSizes.spaceBtwSections,
        ),
        const SectionHeading(
          title: 'Condition',
          showActionButton: false,
        ),
        SizedBox(
          height: TSizes.spaceBtwItems / 2,
        ),
        Chip(
          label: Text(product.productDetails.condition),
        ),
        SizedBox(
          height: TSizes.spaceBtwSections,
        ),
        const SectionHeading(
          title: 'Color',
          showActionButton: false,
        ),
        SizedBox(
          height: TSizes.spaceBtwItems / 2,
        ),
        CircleAvatar(
            radius: 15,
            backgroundColor:
                THelperFunctions.getColor(product.productDetails.color)),
        SizedBox(
          height: TSizes.spaceBtwSections,
        ),
        const SectionHeading(
          title: 'Specifications',
          showActionButton: false,
        ),
        SizedBox(
          height: TSizes.spaceBtwItems / 2,
        ),

        ReadMoreText(
          product.productDetails.productDesc * 7,
          trimLines: 3,
          trimMode: TrimMode.Line,
          trimExpandedText: 'Less',
          trimCollapsedText: 'Show more',
          moreStyle: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(color: Theme.of(context).colorScheme.primary),
          lessStyle: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(color: Theme.of(context).colorScheme.primary),
        ),
        SizedBox(
          height: TSizes.spaceBtwSections,
        ),

        ProductSpecs(
          productSpecs: product.productDetails.productSpecs,
        ),

        ProductStatsCheckboxes(
          product: product,
        ),

        SectionHeading(
          title: 'Reviews',
          onPress: () => Get.to(
            () => ProductReviewsScreen(product: product),
            duration: const Duration(milliseconds: 300),
            transition: Transition.rightToLeft,
          ),
        ),

        UserReviewCard(
         product: product,
        ),

        //TODO: Add similar products if needed

        // const BuildSectionDescription(
        //   sectionName: ' smProducts',
        //   sectionDesc: ' smProductsDesc',
        // ),
      ],
    );
  }
}
