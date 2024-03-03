import 'package:flutter/material.dart';
import 'package:furniture_store/features/home/screens/filters/widgets/og_tab.dart';
import 'package:furniture_store/features/home/screens/filters/widgets/og_tab_item.dart';
import 'package:furniture_store/features/home/screens/filters/widgets/button_group_spaced.dart';
import 'package:furniture_store/features/home/screens/filters/widgets/input_widget.dart';
import 'package:furniture_store/utils/constants/colors.dart';
import 'package:furniture_store/utils/constants/sizes.dart';
import 'package:get/get.dart';

class Filters extends StatelessWidget {
  const Filters({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Filters"),
        actions: [
          IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.clear))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.pagePaddingSpace),
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
                    style: TextStyle(
                      color: TColors.black,
                      fontWeight: FontWeight.w800,
                    ),
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
                  const Text(
                    "Bedrooms",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  OgTab(
                    items: [
                      OgTabItem(
                        title: "Any",
                      ),
                      OgTabItem(
                        title: "1",
                      ),
                      OgTabItem(
                        title: "2",
                      ),
                      OgTabItem(
                        title: "3",
                      ),
                      OgTabItem(
                        title: "4+",
                      ),
                    ],
                  ),
                  SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  const Text(
                    "Bathrooms",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  OgTab(
                    items: [
                      OgTabItem(
                        title: "Any",
                      ),
                      OgTabItem(
                        title: "1",
                      ),
                      OgTabItem(
                        title: "2",
                      ),
                      OgTabItem(
                        title: "3",
                      ),
                      OgTabItem(
                        title: "4+",
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
