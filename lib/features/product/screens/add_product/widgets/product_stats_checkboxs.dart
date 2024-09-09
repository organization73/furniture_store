import 'package:decordashapp/features/product/screens/add_product/controllers/product_stats_checkboxes_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductStatsCheckboxes extends StatelessWidget {
  final ProductStatsCheckboxesController controller;

  ProductStatsCheckboxes({super.key, required Map<String, bool> productStats})
      : controller = Get.put(ProductStatsCheckboxesController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() => Column(
              children: controller.productStats.entries.map((entry) {
                return CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text(entry.key,
                      style: Theme.of(context).textTheme.titleMedium),
                  value: entry.value,
                  onChanged: (newValue) {
                    if (newValue != null) {
                      controller.updateProductStat(entry.key, newValue);
                    }
                  },
                );
              }).toList(),
            )),
      ],
    );
  }
}
