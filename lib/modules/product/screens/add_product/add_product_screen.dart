import 'package:decordashapp/modules/errors/screens/no_connection_screen.dart';
import 'package:decordashapp/modules/product/screens/add_product/collabsable_appbar.dart';
import 'package:decordashapp/utils/helpers/network_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProductPage extends StatelessWidget {
  const AddProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (!NetworkManager.instance.isOnline.value) {
        return const ErrorScreen();
      } else {
        return const CollapsingAppbarWithTabsPage();
      }
    });
  }
}
