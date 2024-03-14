import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:decordash/common/widgets/layouts/grid_layout.dart';
import 'package:decordash/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:decordash/features/product/model/product_model.dart';
import 'package:decordash/features/home/screens/filters/filters.dart';
import 'package:decordash/features/home/screens/filters/widgets/input_widget.dart';
import 'package:decordash/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class CategoriesPage extends StatelessWidget {
  final String categoryName;
  const CategoriesPage({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            floating: true,
            pinned: true,
            snap: false,
            title: Text(
              categoryName,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            bottom: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              toolbarHeight: 55.h,
              title: Row(
                children: [
                  const Expanded(
                    child: InputWidget(
                      height: 40.0,
                      hintText: "Search",
                      prefixIcon: Iconsax.search_normal_copy,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    child: OutlinedButton.icon(
                      onPressed: () => Get.to(
                        () => const Filters(),
                        duration: const Duration(milliseconds: 300),
                        transition: Transition.downToUp,
                      ),
                      icon: const Icon(Iconsax.sort),
                      label: const Text('Filter'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(TSizes.pagePaddingSpace),
                child: GridLayout(
                    itemCount: 8,
                    mainAxisExtent: 265.r,
                    itemBuilder: (_, index) => ProductCardVerical(
                          product: ProductModel.empty(),
                        )),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
