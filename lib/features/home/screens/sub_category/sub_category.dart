import 'package:decordashapp/common/widgets/loaders/animation_loader.dart';
import 'package:decordashapp/common/widgets/shimmer/horizontal_product_shimmer.dart';
import 'package:decordashapp/features/home/controllers/category_controller.dart';
import 'package:decordashapp/features/home/model/category_model.dart';
import 'package:decordashapp/features/home/screens/all_products/all_products_screen.dart';
import 'package:decordashapp/utils/constants/image_strings.dart';
import 'package:decordashapp/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';

import 'package:decordashapp/common/widgets/headings/section_heading.dart';
import 'package:decordashapp/common/widgets/products/product_cards/product_card_horizontal.dart';
import 'package:decordashapp/utils/constants/sizes.dart';
import 'package:get/get.dart';

class SubCategoryScreen extends StatelessWidget {
  const SubCategoryScreen({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return Scaffold(
      appBar: AppBar(
        title: Text(category.name),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: TSizes.pagePaddingSpace),
          child: FutureBuilder(
              future: controller.getSubCategories(category.id),
              builder: (context, snapshot) {
                const emptyWidget = AnimationLoaderWidget(
                  text: 'Whoops! This category is Empty...',
                  animation: TImages.noFiles,
                );
                const loader = HorizontalProductShimmer();
                final widget = TCloudHelperFunctions.checkMultiRecordState(
                    snapshot: snapshot,
                    nothingFound: emptyWidget,
                    loader: loader);
                if (widget != null) return widget;

                final subCategories = snapshot.data!;
                return Column(
                  children: [
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: subCategories.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final subCategory = subCategories[index];
                          return FutureBuilder(
                              future: controller.getCategoryProducts(
                                  categoryId: subCategory.id),
                              builder: (context, snapshot) {
                                final widget =
                                    TCloudHelperFunctions.checkMultiRecordState(
                                        snapshot: snapshot,
                                        nothingFound: emptyWidget,
                                        loader: loader);
                                if (widget != null) return widget;

                                final products = snapshot.data!;
                                return Column(
                                  children: [
                                    SectionHeading(
                                      title: subCategory.name,
                                      onPress: () => Get.to(
                                        () => AllProductsScreen(
                                          title: subCategory.name,
                                          futureMethod:
                                              controller.getCategoryProducts(
                                                  categoryId: subCategory.id,
                                                  limit: -1),
                                        ),
                                        duration:
                                            const Duration(milliseconds: 300),
                                        transition: Transition.rightToLeft,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: TSizes.spaceBtwItems / 2,
                                    ),
                                    SizedBox(
                                      height: 115,
                                      child: ListView.separated(
                                        itemCount: products.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (_, int index) {
                                          return ProductCardHorizontal(
                                            product: products[index],
                                          );
                                        },
                                        separatorBuilder: (_, __) =>
                                            const SizedBox(
                                          width: TSizes.spaceBtwItems,
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              });
                        }),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
