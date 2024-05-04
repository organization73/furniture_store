import 'package:decordash/common/widgets/buttons/cta_button.dart';
import 'package:decordash/common/widgets/layouts/grid_layout.dart';
import 'package:decordash/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:decordash/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:decordash/features/home/controllers/product/product_controller.dart';
import 'package:decordash/features/home/screens/filters/widgets/button_group_spaced.dart';
import 'package:decordash/features/home/screens/filters/widgets/og_tab.dart';
import 'package:decordash/features/home/screens/filters/widgets/og_tab_item.dart';
import 'package:decordash/features/home/screens/search/controllers/recent_search_controller.dart';
import 'package:decordash/common/widgets/input_fields/custom_text_form_field.dart';
import 'package:decordash/utils/constants/sizes.dart';
import 'package:decordash/utils/logging/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RecentSearchController());
    var lang = Get.locale!.languageCode;
    final productsController = ProductController.instance;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 50.h,
        actions: [
          IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(
                Icons.arrow_back_ios,
                size: TSizes.iconMd,
              )),
          Expanded(
            child: CustomTextFormField(
              hint: 'homeSearchBarHint'.tr,
              prefixIcon: Iconsax.search_normal_copy,
              controller: searchController,
              filled: true,
              suffixIcon: Iconsax.close_circle_copy,
              onTapSuffixIcon: () {
                searchController.clear();
              },
              onEditingComplete: () {
                controller.addSearch(searchController.text);
                productsController.fetchSearchProducts(searchController.text);
              },
            ),
          ),
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) => _custombottomSheetFilter(context));
              },
              icon: const Icon(
                Iconsax.filter_copy,
              )),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Previous Searches
              Obx(() => ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.recentSearches.length,
                    itemBuilder: (BuildContext ctx, index) => Dismissible(
                        key: UniqueKey(),
                        onDismissed: (DismissDirection dir) {
                          controller.removeSearch(index);
                        },
                        background: Container(
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          // Adjusting alignment based on the dismiss direction
                          alignment: lang == 'ar'
                              ? Alignment.centerLeft
                              : Alignment.centerRight,
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                        child: ListTile(
                          titleAlignment: ListTileTitleAlignment.titleHeight,
                          leading: const Icon(
                            Iconsax.timer_1_copy,
                          ),
                          title: Text(
                            controller.recentSearches[index],
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        )),
                  )),
              // Search Suggestions
              Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Search Suggestions",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    SizedBox(
                      height: TSizes.spaceBtwSections,
                    ),
                    Row(
                      children: [
                        searchSuggestions("Chair"),
                        searchSuggestions("Bed"),
                      ],
                    ),
                    SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    Row(
                      children: [
                        searchSuggestions("Table"),
                        searchSuggestions("Sofa"),
                      ],
                    ),
                  ],
                ),
              ),

              Obx(() {
                if (productsController.isLoading.value) {
                  return const VerticalProductShimmer();
                }
                if (productsController.searchProducts.isEmpty) {
                  return const Center(child: Text('No Products Found'));
                }
                return GridLayout(
                    mainAxisExtent: 265.r,
                    itemCount: productsController.searchProducts.length,
                    itemBuilder: (_, index) => ProductCardVerical(
                          product: productsController.searchProducts[index],
                        ));
              }),
            ],
          ),
        ),
      ),
    );
  }

  searchSuggestions(String text) {
    return Container(
      margin: const EdgeInsets.only(left: 8),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(30)),
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: Theme.of(context).colorScheme.onPrimaryContainer),
      ),
    );
  }

  _custombottomSheetFilter(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "Add a Filter",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Padding(
            padding: const EdgeInsets.all(TSizes.pagePaddingSpace),
            child: Column(
              children: [
                OgTab(
                  items: [
                    OgTabItem(
                      title: "Sale",
                    ),
                    OgTabItem(
                      title: "Rent",
                    ),
                    OgTabItem(
                      title: "Sold",
                    ),
                  ],
                ),
                SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      "Property Type",
                    ),
                    SizedBox(
                      height: TSizes.spaceBtwSections,
                    ),
                    const ButtonGroupSpaced(
                      items: [
                        "Any",
                        "House",
                        "Apartment",
                        "Office",
                        "Commercial",
                        "Swimming Pool",
                        "Gardens"
                      ],
                    ),
                    SizedBox(
                      height: TSizes.spaceBtwSections,
                    ),
                  ],
                ),
                BuildCTAButton(
                  text: 'Done',
                  onPressed: () => LoggerHelper.info('apply filter'),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
