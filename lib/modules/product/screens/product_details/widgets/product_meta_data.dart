import 'package:flutter/material.dart';
import 'package:decordashapp/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:decordashapp/common/widgets/headings/section_heading.dart';
import 'package:decordashapp/common/widgets/texts/brand_title_text_with_verified_icon.dart';
import 'package:decordashapp/common/widgets/texts/product_price_text.dart';
import 'package:decordashapp/common/widgets/texts/product_title_text.dart';
import 'package:decordashapp/modules/home/controllers/product/product_controller.dart';
import 'package:decordashapp/modules/product/model/product_model.dart';
import 'package:decordashapp/modules/reviews/screens/product_review_screen.dart';
import 'package:decordashapp/modules/product/screens/product_details/widgets/product_specs.dart';
import 'package:decordashapp/modules/product/screens/product_details/widgets/product_status_checkboxes.dart';
import 'package:decordashapp/modules/reviews/widgets/user_review_card.dart';

import 'package:decordashapp/utils/constants/enums.dart';
import 'package:decordashapp/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:readmore/readmore.dart';

class ProductMetaData extends StatelessWidget {
  const ProductMetaData({super.key, required this.product});
  final ProductModel product;

  Color _getColorFromString(String colorString) {
    // Remove unnecessary characters from the color string
    String cleanedColorString = colorString
        .replaceAll("Color(", "")
        .replaceAll(")", "")
        .replaceAll("0x", "");
    // Converting hex string to integer
    int intValue = int.parse(cleanedColorString, radix: 16);
    // Creating Color object from integer value
    return Color(intValue);
  }

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
            if (salePercentage != null)
              Row(
                children: [
                  RoundedContainer(
                    raduis: TSizes.sm,
                    backgroundColor: Colors.amber.withOpacity(0.8),
                    padding: const EdgeInsets.symmetric(
                        horizontal: TSizes.sm, vertical: TSizes.xs),
                    child: Text('$salePercentage%',
                        style: Theme.of(context).textTheme.labelLarge),
                  ),
                  const SizedBox(
                    width: TSizes.spaceBtwItems,
                  ),
                ],
              ),
            if (product.onSale)
              Row(
                children: [
                  ProductPriceText(
                    price: product.productPrice.toStringAsFixed(1),
                    lineThrough: true,
                  ),
                  const SizedBox(
                    width: TSizes.spaceBtwItems,
                  ),
                ],
              ),
            ProductPriceText(
              price: productsController
                  .getProductPrice(product)
                  .toStringAsFixed(1),
              isLarge: true,
            ),
          ],
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        ProductTitleText(title: product.productName),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        BrandTitleTextWithVerifiedIcon(
          vendor: product.productDetails.productSeller,
          beandtextSize: TextSizes.medium,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              IconsaxPlusLinear.location,
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
        const SizedBox(
          height: TSizes.spaceBtwSections,
        ),
        const SectionHeading(
          title: 'Condition',
          showActionButton: false,
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems / 2,
        ),
        Chip(
          label: Text(product.productDetails.condition),
        ),
        const SizedBox(
          height: TSizes.spaceBtwSections,
        ),
        const SectionHeading(
          title: 'Color',
          showActionButton: false,
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems / 2,
        ),
        CircleAvatar(
            radius: 15,
            backgroundColor: _getColorFromString(product.productDetails.color)),
        const SizedBox(
          height: TSizes.spaceBtwSections,
        ),
        const SectionHeading(
          title: 'Specifications',
          showActionButton: false,
        ),
        const SizedBox(
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
              .labelLarge!
              .copyWith(color: Theme.of(context).colorScheme.primary),
          lessStyle: Theme.of(context)
              .textTheme
              .labelLarge!
              .copyWith(color: Theme.of(context).colorScheme.primary),
        ),
        const SizedBox(
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
        if (product.rates.isNotEmpty)
          UserReviewCard(
            product: product,
          ),
      ],
    );
  }
}
