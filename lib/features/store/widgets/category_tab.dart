import 'package:decordash/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:decordash/features/home/controllers/category_controller.dart';
import 'package:decordash/features/store/widgets/category_vendors.dart';
import 'package:decordash/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:decordash/common/widgets/headings/section_heading.dart';
import 'package:decordash/common/widgets/layouts/grid_layout.dart';
import 'package:decordash/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:decordash/features/home/model/category_model.dart';
import 'package:decordash/features/home/screens/all_products/all_products_screen.dart';
import 'package:decordash/utils/constants/sizes.dart';
import 'package:get/get.dart';

class CategoryTab extends StatelessWidget {
  const CategoryTab({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;

    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: TSizes.pagePaddingSpace),
          child: Column(
            children: [
              CategoryVendors(
                category: category,
              ),
              FutureBuilder(
                  future:
                      controller.getCategoryProducts(categoryId: category.id),
                  builder: (context, snapshot) {
                    const loader = VerticalProductShimmer();
                    final widget = TCloudHelperFunctions.checkMultiRecordState(
                        snapshot: snapshot, loader: loader);
                    if (widget != null) return widget;

                    final products = snapshot.data!;
                    return Column(
                      children: [
                        SectionHeading(
                          title: 'You might like',
                          onPress: () => Get.to(
                            () => AllProductsScreen(
                              title: category.name,
                              futureMethod: controller.getCategoryProducts(
                                  categoryId: category.id, limit: -1),
                            ),
                            duration: const Duration(milliseconds: 300),
                            transition: Transition.rightToLeft,
                          ),
                        ),
                        GridLayout(
                            mainAxisExtent: 265.r,
                            itemCount: products.length,
                            itemBuilder: (_, index) {
                              return ProductCardVerical(
                                product: products[index],
                              );
                            }),
                      ],
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
