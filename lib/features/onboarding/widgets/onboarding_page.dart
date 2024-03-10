import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:decordash/features/onboarding/controllers/onboarding_controller.dart';
import 'package:decordash/utils/constants/sizes.dart';

import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class OnBoardingView extends StatelessWidget {
  final OnBoardingController controller;

  const OnBoardingView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
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
                        child:
                            SvgPicture.asset(item.imageUrl, fit: BoxFit.cover),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.all(TSizes.pagePaddingSpace),
                              child: Text(
                                item.title,
                                style:
                                    Theme.of(context).textTheme.headlineLarge,
                              ),
                            ),
                            Container(
                              constraints: BoxConstraints(maxWidth: 250.w),
                              child: Text(
                                item.description,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.labelSmall,
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
            // Current page indicator
            Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: controller.pages
                      .map(
                        (item) => AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          width: controller.currentPage ==
                                  controller.pages.indexOf(item)
                              ? 30
                              : 8,
                          height: 8.h,
                          margin: const EdgeInsets.all(2.0),
                          decoration: BoxDecoration(
                            color: controller.currentPage ==
                                    controller.pages.indexOf(item)
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      )
                      .toList(),
                )),
            // Bottom buttons
            Padding(
              padding: const EdgeInsets.all(TSizes.pagePaddingSpace),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: controller.onFinish,
                    child: Text('skip'.tr,
                        style: Theme.of(context).textTheme.labelSmall),
                  ),
                  Obx(() => IconButton(
                        tooltip: 'tContinue'.tr,
                        color: Theme.of(context).colorScheme.primary,
                        onPressed: () {
                          if (controller.currentPage ==
                              controller.pages.length - 1) {
                            controller.onFinish();
                          } else {
                            controller.pageController.animateToPage(
                              controller.currentPage + 1,
                              curve: Curves.easeInOutCubic,
                              duration: const Duration(milliseconds: 250),
                            );
                          }
                        },
                        icon: Icon(
                            controller.currentPage ==
                                    controller.pages.length - 1
                                ? Iconsax.tick_circle
                                : Iconsax.arrow_circle_right,
                            size: TSizes.iconLg),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
