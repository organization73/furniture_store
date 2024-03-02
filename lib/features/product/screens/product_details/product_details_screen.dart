import 'package:flutter/material.dart';
import 'package:furniture_store/features/product/screens/product_details/widgets/product_image_slider.dart';
import 'package:furniture_store/features/product/screens/product_details/widgets/product_meta_data.dart';
import 'package:furniture_store/features/product/screens/product_details/widgets/product_rating_container.dart';
import 'package:furniture_store/global/global_variables.dart';
import 'package:furniture_store/utils/constants/sizes.dart';
import 'package:get/get.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        height: 70,
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
            const ProductImageSlider(),
            Padding(
              padding: EdgeInsets.only(
                  right: TSizes.pagePaddingSpace,
                  left: TSizes.pagePaddingSpace,
                  bottom: TSizes.pagePaddingSpace),
              child: Column(
                children: [
                  const RatingWidget(),
                  SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  ProductMetaData(
                    product: allProductsList[1],
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
