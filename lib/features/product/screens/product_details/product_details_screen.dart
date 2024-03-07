import 'package:flutter/material.dart';
import 'package:furniture_store/features/home/model/product_model.dart';
import 'package:furniture_store/features/product/screens/product_details/widgets/product_image_slider.dart';
import 'package:furniture_store/features/product/screens/product_details/widgets/product_meta_data.dart';
import 'package:furniture_store/features/product/screens/product_details/widgets/product_rating_container.dart';
import 'package:furniture_store/global/global_variables.dart';
import 'package:furniture_store/utils/constants/sizes.dart';
import 'package:get/get.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.product});
  final ProductModel product;

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
             ProductImageSlider(product: product,),
            Padding(
              padding: EdgeInsets.only(
                  right: TSizes.pagePaddingSpace,
                  left: TSizes.pagePaddingSpace,
                  bottom: TSizes.pagePaddingSpace),
              child: Column(
                children: [
                   RatingWidget(product: product,),
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
