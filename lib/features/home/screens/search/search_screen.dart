import 'package:decordash/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:decordash/features/home/screens/search/controllers/recent_search_controller.dart';
import 'package:decordash/common/widgets/input_fields/custom_text_form_field.dart';
import 'package:decordash/features/home/screens/search/controllers/search_controller.dart';
import 'package:decordash/features/home/widgets/sortable_products.dart';
import 'package:decordash/utils/constants/sizes.dart';
import 'package:decordash/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ActionChipData {
  final IconData icon;
  final String label;

  ActionChipData({required this.icon, required this.label});
}

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searchPageController = Get.put(SearchPageController());
    final recentSearchController = Get.put(RecentSearchController());
    final List<ActionChipData> actionChips = [
      ActionChipData(icon: Icons.add, label: 'Wooden Chair'),
      ActionChipData(icon: Icons.edit, label: 'White Table'),
      ActionChipData(icon: Icons.delete, label: 'Red Bed'),
    ];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 60.r,
        actions: [
          IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back_ios,
            ),
          ),
          Expanded(
            child: CustomTextFormField(
              hint: 'homeSearchBarHint'.tr,
              prefixIcon: Iconsax.search_normal_copy,
              controller: searchPageController.searchController,
              filled: true,
              suffixIcon: Iconsax.close_circle_copy,
              onTapSuffixIcon: () {
                searchPageController.searchController.clear();
                // Reset the state if the search bar is cleared
                searchPageController.isSearchSubmitted.value = false;
              },
              onEditingComplete: () {
                recentSearchController
                    .addSearch(searchPageController.searchController.text);
                searchPageController.fetchSearchProducts();
              },
            ),
          ),
          SizedBox(
            width: 20.w,
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(TSizes.pagePaddingSpace),
            child: Obx(() {
              if (searchPageController.isSearchSubmitted.value) {
                // Show search results
                return FutureBuilder(
                    future: searchPageController.fetchSearchProducts(),
                    builder: (context, snapshot) {
                      const loader = VerticalProductShimmer();
                      final widget =
                          TCloudHelperFunctions.checkMultiRecordState(
                              snapshot: snapshot, loader: loader);
                      if (widget != null) return widget;

                      final products = snapshot.data!;
                      return SortableProducts(
                        products: products,
                        loadMoreProducts: () {
                          print("loaddded more searchinggg products");
                        },
                      );
                    });
              } else {
                // Show recent searches and search suggestions
                return Column(
                  children: [
                    // Previous Searches
                    Obx(() => ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount:
                              recentSearchController.recentSearches.length,
                          itemBuilder: (BuildContext ctx, index) => Dismissible(
                            key: UniqueKey(),
                            direction: DismissDirection.endToStart,
                            onDismissed: (_) {
                              recentSearchController.removeSearch(index);
                            },
                            background: Container(
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              alignment: Get.locale!.languageCode == 'ar'
                                  ? Alignment.centerLeft
                                  : Alignment.centerRight,
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                            child: ListTile(
                              onTap: () {
                                // Set the search text to the tapped item's text
                                searchPageController.searchController.text =
                                    recentSearchController
                                        .recentSearches[index];
                                // Trigger the search
                                searchPageController.fetchSearchProducts();
                              },
                              titleAlignment:
                                  ListTileTitleAlignment.titleHeight,
                              leading: const Icon(Iconsax.timer_1_copy),
                              title: Text(
                                recentSearchController.recentSearches[index],
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          ),
                        )),
                    // Search Suggestions
                    Container(
                      padding: const EdgeInsets.all(TSizes.pagePaddingSpace),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            "Search Suggestions",
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          SizedBox(height: TSizes.spaceBtwSections),
                          Wrap(
                            runSpacing: 2,
                            spacing: 15,
                            children: actionChips
                                .map((actionChip) => ActionChip(
                                      label: Text(actionChip.label),
                                      onPressed: () {
                                        // Set the search text to the tapped item's text
                                        searchPageController.searchController
                                            .text = actionChip.label;
                                        // Trigger the search
                                        searchPageController
                                            .fetchSearchProducts();
                                      },
                                    ))
                                .toList(),
                          )
                        ],
                      ),
                    ),
                  ],
                );
              }
            }),
          ),
        ),
      ),
    );
  }
}
