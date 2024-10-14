import 'package:flutter/material.dart';
import 'package:get/get.dart';

class THelperFunctions {
  static void showSnackBar(String message) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  static void showAlert(String title, String message) {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  static void showLanguageModel() {
    showModalBottomSheet<void>(
      context: Get.overlayContext!,
      showDragHandle: true,
      builder: (BuildContext context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'selectLan'.tr,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            ListTile(
              title: Text(
                'English',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              leading: const Text(
                'en',
                style: TextStyle(fontSize: 25),
              ),
              onTap: () {
                Get.updateLocale(const Locale('en', 'US'));
                Get.back();
              },
            ),
            ListTile(
              title: Text(
                'Arabic',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              leading: const Text(
                'ar',
                style: TextStyle(fontSize: 25),
              ),
              onTap: () {
                Get.updateLocale(const Locale('ar', 'SA'));
                Get.back();
              },
            ),
          ],
        );
      },
    );
  }
}
