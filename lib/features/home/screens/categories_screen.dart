import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furniture_store/common/widgets/layouts/grid_layout.dart';
import 'package:furniture_store/common/widgets/products/product_card_vertical.dart';
import 'package:furniture_store/features/home/widgets/search_bar.dart';
import 'package:furniture_store/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';

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
              toolbarHeight: 120.h,
              title: Column(
                children: [
                  Row(
                    children: [
                      FilledButton.icon(
                        icon: Icon(Iconsax.filter,
                            color:
                                Theme.of(context).textTheme.labelSmall?.color,
                            size: TSizes.md),
                        label: Text('Filters',
                            style: Theme.of(context).textTheme.labelSmall),
                        onPressed: () {},
                        style: FilledButton.styleFrom(
                            surfaceTintColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            foregroundColor: Colors.black,
                            backgroundColor: Colors.transparent),
                      ),
                      FilledButton.icon(
                        icon: Icon(Icons.compare_arrows,
                            color:
                                Theme.of(context).textTheme.labelSmall?.color,
                            size: TSizes.md),
                        label: Text('Price: lowest to high',
                            style: Theme.of(context).textTheme.labelSmall),
                        onPressed: () {},
                        style: FilledButton.styleFrom(
                            surfaceTintColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            foregroundColor: Colors.black,
                            backgroundColor: Colors.transparent),
                      )
                    ],
                  ),
                  const BuildSearchBar()
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                child: GridLayout(
                    itemCount: 4,
                    itemBuilder: (_, index) => const ProductCardVerical()),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
