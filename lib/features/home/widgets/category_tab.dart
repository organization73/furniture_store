import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:furniture_store/common/widgets/galleries/gallery_showcase.dart';
import 'package:furniture_store/common/widgets/headings/section_heading.dart';
import 'package:furniture_store/common/widgets/layouts/grid_layout.dart';
import 'package:furniture_store/common/widgets/products/product_card_vertical.dart';
import 'package:furniture_store/features/home/controllers/product/product_controller.dart';
import 'package:furniture_store/features/home/model/category_model.dart';
import 'package:furniture_store/features/home/model/product_model.dart';
import 'package:furniture_store/features/home/screens/all_products/all_products_screen.dart';
import 'package:furniture_store/utils/constants/image_strings.dart';
import 'package:furniture_store/utils/constants/sizes.dart';
import 'package:get/get.dart';

class CategoryTab extends StatelessWidget {
  const CategoryTab({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: TSizes.pagePaddingSpace),
          child: Column(
            children: [
              const GelleryShowCase(
                
                images: [
                  TImages.productImage1,
                  TImages.productImage1,
                  TImages.productImage1
                ],
              ),
              SectionHeading(
                title: 'You might like',
                onPress: () => Get.to(
                  () => AllProductsScreen(
                    title: 'Popular Prodcuts',
                    futureMethod: controller.fetchAllFeaturedProducts(),
                  ),
                  duration: const Duration(milliseconds: 300),
                  transition: Transition.rightToLeft,
                ),
              ),
              GridLayout(
                  itemCount: 4,
                  itemBuilder: (_, index) {
                    return ProductCardVerical(
                      product: ProductModel.empty(),
                    );
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
