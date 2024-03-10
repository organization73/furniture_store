import 'package:flutter/material.dart';

import 'package:decordash/features/onboarding/controllers/onboarding_controller.dart';
import 'package:decordash/features/onboarding/model/page_model.dart';
import 'package:decordash/features/onboarding/widgets/onboarding_page.dart';
import 'package:decordash/utils/constants/image_strings.dart';
import 'package:get/get.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController(
      pages: [
        OnboardingPageModel(
          title: 'onBoardingTitle1'.tr,
          description: 'onBoardingSubTitle1'.tr,
          imageUrl: TImages.onBoardingImage1,
        ),
        OnboardingPageModel(
          title: 'onBoardingTitle2'.tr,
          description: 'onBoardingSubTitle2'.tr,
          imageUrl: TImages.onBoardingImage2,
        ),
        OnboardingPageModel(
          title: 'onBoardingTitle3'.tr,
          description: 'onBoardingSubTitle3'.tr,
          imageUrl: TImages.onBoardingImage3,
        ),
      ],
    ));

    return OnBoardingView(controller: controller);
  }
}
