import 'package:decordashapp/utils/device/device_utility.dart';
import 'package:flutter/material.dart';

import 'package:decordashapp/common/widgets/layouts/grid_layout.dart';
import 'package:decordashapp/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:decordashapp/features/home/controllers/product/all_products_controller.dart';
import 'package:decordashapp/features/product/model/product_model.dart';
import 'package:decordashapp/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class SortableProducts extends StatelessWidget {
  const SortableProducts({super.key, required this.products});
  final List<ProductModel> products;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductsController());
    controller.assignProducts(products);
    return Column(
      children: [
        DropdownButtonFormField(
            decoration:
                const InputDecoration(prefixIcon: Icon(Iconsax.sort_copy)),
            value: controller.selectedSortOption.value,
            items: [
              'Name',
              'Higher Price',
              'Lower Price',
              'Sale',
              'Newest',
            ]
                .map((option) =>
                    DropdownMenuItem(value: option, child: Text(option)))
                .toList(),
            onChanged: (value) {
              controller.sortProducts(value!);
            }),
        const SizedBox(
          height: TSizes.spaceBtwSections * 1.5,
        ),
        Obx(() => GridLayout(
            mainAxisExtent: TDeviceUtils.getScreenOrientation(context) ==
                    Orientation.portrait
                ? TDeviceUtils.getScreenHeight() * 0.31
                : TDeviceUtils.getScreenHeight() * 0.4,
            itemCount: controller.products.length,
            itemBuilder: (__, index) =>
                ProductCardVerical(product: controller.products[index])))
      ],
    );
  }
}
