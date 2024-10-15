import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:markdown_widget/markdown_widget.dart';

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

  static void showTermsBottomSheet(BuildContext context, String filePath) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: FutureBuilder(
            future: rootBundle.loadString(filePath),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.hasData) {
                return MarkdownWidget(
                  config: MarkdownConfig(configs: [
                    const PConfig(textStyle: TextStyle(fontSize: 13)),
                    H1Config(
                        style: Theme.of(context).textTheme.headlineMedium!),
                    H2Config(style: Theme.of(context).textTheme.headlineSmall!),
                    H3Config(style: Theme.of(context).textTheme.titleMedium!),
                    H4Config(style: Theme.of(context).textTheme.titleSmall!),
                    const TableConfig(
                      columnWidths: {0: FractionColumnWidth(0.25)},
                    ),
                    ListConfig(
                      marker: (isOrdered, depth, index) => const Padding(
                        padding: EdgeInsets.only(top: 6),
                        child: Icon(Icons.circle, size: 6),
                      ),
                    ),
                  ]),
                  data: snapshot.data!,
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        );
      },
    );
  }
}
