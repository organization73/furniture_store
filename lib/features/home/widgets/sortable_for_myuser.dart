import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:decordash/features/home/controllers/product/all_products_controller.dart';
import 'package:decordash/features/product/model/product_model.dart';
import 'package:decordash/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:decordash/common/widgets/products/favourite_icon/favourite_icon.dart';
import 'package:decordash/common/styles/shadows.dart';
import 'package:decordash/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:decordash/common/widgets/images/rounded_image.dart';
import 'package:decordash/common/widgets/texts/brand_title_text_with_verified_icon.dart';
import 'package:decordash/common/widgets/texts/product_price_text.dart';
import 'package:decordash/common/widgets/texts/product_title_text.dart';
import 'package:decordash/features/home/controllers/product/product_controller.dart';
import 'package:decordash/features/product/screens/product_details/product_details_screen.dart';

class SortedProductForMyUser extends StatelessWidget {
  const SortedProductForMyUser(
      {super.key, required this.products, required this.loadMoreProducts});
  final List<ProductModel> products;
  final Function loadMoreProducts;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductsController());
    controller.assignProducts(products);
    return Column(
      children: [
        DropdownButtonFormField(
            decoration:
                const InputDecoration(prefixIcon: Icon(Iconsax.sort_copy)),
            value: controller.selectedSortOption.value,
            items: [
              'Newest',
              'Higher Price',
              'Lower Price',
              'Name',
            ]
                .map((option) =>
                    DropdownMenuItem(value: option, child: Text(option)))
                .toList(),
            onChanged: (value) {
              controller.sortProducts(value!);
            }),
        SizedBox(
          height: TSizes.spaceBtwSections * 1.5,
        ),
        Obx(() => GridLayout(
            mainAxisExtent: 265.r,
            itemCount: controller.products.length,
            itemBuilder: (__, index) =>
                ProductCardVerical(product: controller.products[index]))),
      ],
    );
  }
}

class GridLayout extends StatelessWidget {
  const GridLayout({
    super.key,
    required this.itemCount,
    this.mainAxisExtent = 250,
    required this.itemBuilder,
  });

  final int itemCount;
  final double? mainAxisExtent;
  final Widget? Function(BuildContext, int) itemBuilder;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: itemCount,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: TSizes.gridViewSpacing,
            crossAxisSpacing: TSizes.gridViewSpacing,
            mainAxisExtent: mainAxisExtent),
        itemBuilder: itemBuilder);
  }
}

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
              hight: 135.h,
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
                ],
              ),
            ),
            SizedBox(
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
                    SizedBox(
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
                  Icon(
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
