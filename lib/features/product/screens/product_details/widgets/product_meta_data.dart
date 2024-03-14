import 'package:flutter/material.dart';
import 'package:decordash/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:decordash/common/widgets/headings/section_heading.dart';
import 'package:decordash/common/widgets/texts/brand_title_text_with_verified_icon.dart';
import 'package:decordash/common/widgets/texts/product_price_text.dart';
import 'package:decordash/common/widgets/texts/product_title_text.dart';
import 'package:decordash/features/home/controllers/product/product_controller.dart';
import 'package:decordash/features/product/model/product_model.dart';
import 'package:decordash/features/product/screens/product_reviews/product_review_screen.dart';
import 'package:decordash/features/product/screens/product_details/widgets/product_specs.dart';
import 'package:decordash/features/product/screens/product_details/widgets/product_status_checkboxes.dart';
import 'package:decordash/features/product/screens/product_reviews/widgets/user_review_card.dart';
import 'package:decordash/utils/constants/colors.dart';
import 'package:decordash/utils/constants/enums.dart';
import 'package:decordash/utils/constants/sizes.dart';
import 'package:decordash/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:readmore/readmore.dart';

class ProductMetaData extends StatelessWidget {
  const ProductMetaData({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final productsController = ProductController.instance;
    final salePercentage = productsController.calculateSalePercnetage(
        product.productPrice, product.productSalePrice);

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
                '$salePercentage%',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .apply(color: TColors.black),
              ),
            ),
            SizedBox(
              width: TSizes.spaceBtwItems,
            ),
            if (product.onSale)
              ProductPriceText(
                price: product.productPrice.toStringAsFixed(1),
                lineThrough: true,
              ),
            SizedBox(
              width: TSizes.spaceBtwItems,
            ),
            ProductPriceText(
              price: productsController
                  .getProductPrice(product)
                  .toStringAsFixed(1),
              isLarge: true,
            ),
          ],
        ),
        SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        ProductTitleText(title: product.productName),
        SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        BrandTitleTextWithVerifiedIcon(
          title: product.productDetails.productSeller.name,
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
              product.productDetails.productSeller.location,
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
      ],
    );
  }
}
