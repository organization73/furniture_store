import 'package:decordash/common/widgets/loaders/animation_loader.dart';
import 'package:decordash/common/widgets/shimmer/horizontal_product_shimmer.dart';
import 'package:decordash/features/favourits/controllers/favorite_controller.dart';
import 'package:decordash/features/home/controllers/category_controller.dart';
import 'package:decordash/features/home/model/category_model.dart';
import 'package:decordash/features/home/screens/all_products/all_category_products_screen.dart';
import 'package:decordash/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:decordash/common/widgets/headings/section_heading.dart';
import 'package:decordash/common/widgets/products/product_cards/product_card_horizontal.dart';
import 'package:decordash/utils/constants/sizes.dart';
import 'package:get/get.dart';

class SubCategoryScreen extends StatelessWidget {
  const SubCategoryScreen({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    Get.put(() => FavoriteController());
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
                  animation: 'assets/animations/empty-file.json',
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
                                if (widget != null) {
                                  return Column(
                                    children: [
                                      SectionHeading(
                                        title: subCategory.name,
                                        onPress: () => Get.to(
                                          () => AllCatergoryProductsScreen(
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
                                      widget,
                                    ],
                                  );
                                }

                                final products = snapshot.data!;
                                return Column(
                                  children: [
                                    SectionHeading(
                                      title: subCategory.name,
                                      onPress: () => Get.to(
                                        () => AllCatergoryProductsScreen(
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
                                    SizedBox(
                                      height: TSizes.spaceBtwItems / 2,
                                    ),
                                    SizedBox(
                                      height: 115.r,
                                      child: ListView.separated(
                                        itemCount: products.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (_, int index) {
                                          return ProductCardHorizontal(
                                            product: products[index],
                                          );
                                        },
                                        separatorBuilder: (_, __) => SizedBox(
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
