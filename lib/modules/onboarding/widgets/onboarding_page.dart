import 'package:decordashapp/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:decordashapp/modules/onboarding/controllers/onboarding_controller.dart';
import 'package:decordashapp/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            GetBuilder<OnBoardingController>(
              init: OnBoardingController(),
              builder: (controller) => Expanded(
                child: PageView.builder(
                  controller: controller.pageController,
                  itemCount: controller.pages.length,
                  onPageChanged: controller.onPageChanged,
                  itemBuilder: (context, idx) {
                    final item = controller.pages[idx];
                    return Column(
                      children: [
                        Expanded(
                          flex: 2,
                          child: SvgPicture.asset(item.imageUrl,
                              fit: BoxFit.cover),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(
                                    TSizes.pagePaddingSpace),
                                child: Text(item.title,
                                    style:
                                        Theme.of(context).textTheme.titleLarge),
                              ),
                              Container(
                                constraints: BoxConstraints(
                                    maxWidth:
                                        TDeviceUtils.getScreenWidth(context) *
                                            0.75),
                                child: Text(
                                  item.description,
                                  textAlign: TextAlign.center,
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),

            // Current page indicator
            GetBuilder<OnBoardingController>(
              builder: (controller) => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: controller.pages
                    .map(
                      (item) => AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        width: controller.currentPage ==
                                controller.pages.indexOf(item)
                            ? 30
                            : 8,
                        height: 8,
                        margin: const EdgeInsets.all(2.0),
                        decoration: BoxDecoration(
                          color: controller.currentPage ==
                                  controller.pages.indexOf(item)
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            GetBuilder<OnBoardingController>(
              builder: (controller) => Padding(
                padding: const EdgeInsets.all(TSizes.pagePaddingSpace),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    controller.currentPage != controller.pages.length - 1
                        ? TextButton(
                            onPressed: controller.skip,
                            child: Text('skip'.tr,
                                style: Theme.of(context).textTheme.labelSmall),
                          )
                        : const SizedBox.shrink(),
                    IconButton(
                      onPressed: controller.nextPage,
                      icon: const Icon(IconsaxPlusLinear.arrow_circle_right,
                          size: TSizes.iconLg),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
