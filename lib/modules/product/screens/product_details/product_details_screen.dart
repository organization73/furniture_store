import 'package:decordashapp/common/widgets/buttons/cta_button.dart';
import 'package:flutter/material.dart';
import 'package:decordashapp/modules/product/model/product_model.dart';
import 'package:decordashapp/modules/product/screens/product_details/widgets/product_image_slider.dart';
import 'package:decordashapp/modules/product/screens/product_details/widgets/product_meta_data.dart';
import 'package:decordashapp/modules/product/screens/product_details/widgets/product_rating_container.dart';
import 'package:decordashapp/utils/constants/sizes.dart';
import 'package:get/get.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: BuildCTAButton(
          text: 'contactSeller'.tr,
          onPressed: () {},
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProductImageSlider(
              product: product,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  right: TSizes.pagePaddingSpace,
                  left: TSizes.pagePaddingSpace,
                  bottom: TSizes.pagePaddingSpace),
              child: Column(
                children: [
                  RatingWidget(
                    product: product,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  ProductMetaData(
                    product: product,
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
