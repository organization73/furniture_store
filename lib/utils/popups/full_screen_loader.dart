import 'package:decordashapp/common/widgets/loaders/animation_loader.dart';
import 'package:decordashapp/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FullScreenLoader {
  static void openLoadingDialog(String text, String animation) {
    showDialog(
        context: Get.overlayContext!,
        useSafeArea: false,
        barrierDismissible: false,
        builder: (_) => PopScope(
            canPop: false,
            child: Container(
              color: Theme.of(Get.context!).colorScheme.surfaceContainer,
              width: double.infinity,
              height: double.infinity,
              child: Center(
                child: AnimationLoaderWidget(
                  text: text,
                  animation: animation,
                ),
              ),
            )));
  }

  static void openSmallLoadingDialog(String text) {
    showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (_) => PopScope(
            canPop: false,
            child: Dialog(
              backgroundColor:
                  Theme.of(Get.context!).colorScheme.surfaceContainer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    Text(text),
                  ],
                ),
              ),
            )));
  }

  static stopLoading() {
    Navigator.of(Get.overlayContext!).pop();
  }
}
