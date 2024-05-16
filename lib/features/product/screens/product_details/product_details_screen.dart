import 'package:flutter/material.dart';
import 'package:decordash/features/product/model/product_model.dart';
import 'package:decordash/features/product/screens/product_details/widgets/product_image_slider.dart';
import 'package:decordash/features/product/screens/product_details/widgets/product_meta_data.dart';
import 'package:decordash/features/product/screens/product_details/widgets/product_rating_container.dart';
import 'package:decordash/utils/constants/sizes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        height: 70.h,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: ElevatedButton(
          child: Text(
            'contactSeller'.tr,
          ),
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
                  SizedBox(
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
