import 'package:decordash/features/home/screens/home_screen.dart';
import 'package:decordash/features/home/screens/search/widgets/CustomSlider.dart';
import 'package:decordash/features/home/screens/search/widgets/custom_Text_Form_fild.dart';
import 'package:decordash/features/home/screens/search/widgets/custom_button.dart';
import 'package:decordash/features/home/screens/search/widgets/custom_categories_list.dart';
import 'package:decordash/utils/constants/sizes.dart';
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
  static List previousSearchs = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Search Bar
            SizedBox(
              height: 50.h,
              child: Row(
                children: [
                  IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        size: TSizes.iconMd,
                      )),
                  Expanded(
                    child: CostomTextFormFild(
                      hint: "Serch",
                      prefixIcon: Iconsax.search_normal_copy,
                      controller: searchController,
                      filled: true,
                      suffixIcon: searchController.text.isEmpty
                          ? null
                          : Iconsax.close_circle_copy,
                      onTapSuffixIcon: () {
                        searchController.clear();
                      },
                      onChanged: (pure) {
                        setState(() {});
                      },
                      onEditingComplete: () {
                        previousSearchs.add(searchController.text);
                        Get.back();
                      },
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          showModalBottomSheet(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(25),
                                ),
                              ),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              context: context,
                              builder: (context) =>
                                  _custombottomSheetFilter(context));
                        });
                      },
                      icon: const Icon(
                        Iconsax.filter_copy,
                      )),
                ],
              ),
            ),

            SizedBox(
              height: 5.h,
            ),

            // Previous Searches
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: previousSearchs.length,
                itemBuilder: (context, index) => previousSearchsItem(index)),
            SizedBox(
              height: 5.h,
            ),

            // Search Suggestions
            Container(
              width: double.infinity,
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
                      searchSuggestionsTiem("suchi"),
                      searchSuggestionsTiem("sandwich"),
                    ],
                  ),
                  SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  Row(
                    children: [
                      searchSuggestionsTiem("seafood"),
                      searchSuggestionsTiem("fried rice"),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  previousSearchsItem(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: InkWell(
        onTap: () {},
        child: Dismissible(
          key: GlobalKey(),
          onDismissed: (DismissDirection dir) {
            setState(() {});
            previousSearchs.removeAt(index);
          },
          child: Row(
            children: [
              const Icon(
                Iconsax.timer_1_copy,
              ),
              SizedBox(
                width: 10.w,
              ),
              Text(previousSearchs[index],
                  style: Theme.of(context).textTheme.bodyMedium),
              const Spacer(),
              const Icon(
                Icons.call_made_outlined,
                color: Colors.blue,
              )
            ],
          ),
        ),
      ),
    );
  }

  searchSuggestionsTiem(String text) {
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
    return Container(
      padding: const EdgeInsets.all(20),
      height: 500,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "Add a Filter",
            style: Theme.of(context).textTheme.displayMedium,
          ),
          const CustomCategoriesList(),
          const CustomSlider(),
          Row(
            children: [
              Expanded(
                  child: CustomButton(
                onTap: () {
                  Navigator.pop(context);
                },
                text: "Cancel",
                color: Colors.blue,
                textColor: Colors.blue,
              )),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                  child: CustomButton(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ));
                },
                text: "Done",
              ))
            ],
          )
        ],
      ),
    );
  }
}
