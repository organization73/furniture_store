import 'package:decordashapp/common/widgets/products/favourite_icon/favourite_icon.dart';
import 'package:decordashapp/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:decordashapp/common/styles/shadows.dart';
import 'package:decordashapp/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:decordashapp/common/widgets/images/rounded_image.dart';
import 'package:decordashapp/common/widgets/texts/brand_title_text_with_verified_icon.dart';
import 'package:decordashapp/common/widgets/texts/product_price_text.dart';
import 'package:decordashapp/common/widgets/texts/product_title_text.dart';
import 'package:decordashapp/features/home/controllers/product/product_controller.dart';
import 'package:decordashapp/features/product/model/product_model.dart';
import 'package:decordashapp/features/product/screens/product_details/product_details_screen.dart';
import 'package:decordashapp/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ProductCardVerical extends StatelessWidget {
  const ProductCardVerical({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final productsController = ProductController.instance;
    final salePercentage = productsController.calculateSalePercnetage(
        product.productPrice, product.productSalePrice);

    return GestureDetector(
      onTap: () => Get.to(
        () => ProductDetailsScreen(
          product: product,
        ),
        duration: const Duration(milliseconds: 300),
        transition: Transition.rightToLeft,
      ),
      child: Container(
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [ShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(TSizes.productImageRadius),
          color: Theme.of(context).colorScheme.surfaceContainer,
        ),
        child: Column(
          children: [
            RoundedContainer(
              hight: TDeviceUtils.getScreenHeight() * 0.15,
              width: double.infinity,
              padding: const EdgeInsets.all(TSizes.sm),
              backgroundColor: Theme.of(context).colorScheme.surface,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: RoundedImage(
                      imageUrl: product.productImage,
                      isNetworkImage: true,
                    ),
                  ),
                  if (product.onSale)
                    Positioned(
                      top: 10,
                      left: 0,
                      child: RoundedContainer(
                        raduis: TSizes.sm,
                        backgroundColor: Colors.amber.withOpacity(0.8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: TSizes.sm, vertical: TSizes.xs),
                        child: Text('$salePercentage%',
                            style: Theme.of(context).textTheme.labelMedium),
                      ),
                    ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: FavouriteIcon(
                      productId: product.id,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems / 2,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: TSizes.sm),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProductTitleText(
                      title: product.productName,
                      smallSize: true,
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwItems / 2,
                    ),
                    BrandTitleTextWithVerifiedIcon(
                        vendor: product.productDetails.productSeller),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(TSizes.sm),
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (product.onSale)
                          ProductPriceText(
                            price: product.productPrice.toStringAsFixed(1),
                            lineThrough: true,
                          ),
                        ProductPriceText(
                          price: productsController
                              .getProductPrice(product)
                              .toStringAsFixed(1),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  const Icon(
                    Iconsax.star,
                    color: Colors.amber,
                    size: TSizes.iconSm,
                  ),
                  const SizedBox(
                    width: TSizes.xs,
                  ),
                  Text(
                    product.productRating.toStringAsFixed(1),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
