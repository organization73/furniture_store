import 'package:decordashapp/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:decordashapp/modules/authentication/screens/user_login/user_login_screen.dart';
import 'package:decordashapp/modules/onboarding/model/onboarding_page_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class OnBoardingController extends GetxController {
  int _currentPage = 0;
  final _storage = GetStorage();

  final PageController pageController = PageController(initialPage: 0);
  final List<OnboardingPageModel> pages = [
    OnboardingPageModel(
      title: 'onBoardingTitle1'.tr,
      description: 'onBoardingSubTitle1'.tr,
      imageUrl: ImageStrings.onBoardingImage1,
    ),
    OnboardingPageModel(
      title: 'onBoardingTitle2'.tr,
      description: 'onBoardingSubTitle2'.tr,
      imageUrl: ImageStrings.onBoardingImage2,
    ),
    OnboardingPageModel(
      title: 'onBoardingTitle3'.tr,
      description: 'onBoardingSubTitle3'.tr,
      imageUrl: ImageStrings.onBoardingImage3,
    ),
  ];

  int get currentPage => _currentPage;

  void onPageChanged(int index) {
    _currentPage = index;
    update();
  }

  void nextPage() {
    if (_currentPage < pages.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOutCubic,
      );
    } else {
      onFinish();
    }
  }

  void onFinish() {
    _storage.write('isFirstTime', false);
    Get.offAll(
      () => const UserLoginScreen(),
    );
  }

  void skip() {
    onFinish();
  }
}
