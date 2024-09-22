import 'package:flutter/material.dart';

import 'package:get/get.dart';

class TLoaders {
  static hideSnackBar() =>
      ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar();

  static customToast({required messege}) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
      elevation: 0,
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.transparent,
      content: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Theme.of(Get.context!).colorScheme.surfaceContainer),
        child: Text(
          messege,
          style: Theme.of(Get.context!)
              .textTheme
              .titleSmall
              ?.copyWith(color: Theme.of(Get.context!).colorScheme.onSurface),
          textAlign: TextAlign.center,
        ),
      ),
    ));
  }

  static successSnackBar({required title, message = '', duration = 2}) {
    Get.snackbar(title, message,
        isDismissible: true,
        shouldIconPulse: true,
        colorText: Theme.of(Get.context!).colorScheme.onPrimary,
        backgroundColor: Theme.of(Get.context!).colorScheme.primary,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: duration),
        margin: const EdgeInsets.all(10),
        icon: Icon(
          Icons.check_circle_outline_outlined,
          color: Theme.of(Get.context!).colorScheme.onPrimary,
        ));
  }

  static warningSnackBar({required title, message = ''}) {
    Get.snackbar(title, message,
        isDismissible: true,
        shouldIconPulse: true,
        colorText: Colors.white,
        backgroundColor: Colors.orange,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
        margin: const EdgeInsets.all(10),
        icon: const Icon(
          Icons.warning_amber_rounded,
          color: Colors.white,
        ));
  }

  static errorSnackBar({required title, message = ''}) {
    Get.snackbar(title, message,
        isDismissible: true,
        shouldIconPulse: true,
        colorText: Theme.of(Get.context!).colorScheme.onError,
        backgroundColor: Theme.of(Get.context!).colorScheme.error,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
        margin: const EdgeInsets.all(10),
        icon: Icon(
          Icons.warning_amber_rounded,
          color: Theme.of(Get.context!).colorScheme.onError,
        ));
  }
}
