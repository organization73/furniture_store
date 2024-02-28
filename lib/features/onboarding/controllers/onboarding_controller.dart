import 'package:flutter/material.dart';
import 'package:furniture_store/features/authentication/screens/login/login_screen.dart';
import 'package:furniture_store/features/onboarding/model/page_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class OnBoardingController extends GetxController {
  final _currentPage = 0.obs;
  final storage = GetStorage();

  final PageController pageController = PageController(initialPage: 0);
  final List<OnboardingPageModel> pages;

  OnBoardingController({
    required this.pages,
  });

  int get currentPage => _currentPage.value;

  void onPageChanged(int index) {
    _currentPage.value = index;
  }

  void nextPage() {
    if (_currentPage.value < pages.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOutCubic,
      );
    } else {
      onFinish();
    }
  }

  void onFinish() {
    storage.write('isFirstTime', false);
    Get.offAll(
      () => const LoginSignUpScreen(),
      duration: const Duration(milliseconds: 300),
      transition: Transition.fade,
    );
  }

  void skip() {
    onFinish();
  }
}
