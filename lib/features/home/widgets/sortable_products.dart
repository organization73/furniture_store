import 'package:flutter/material.dart';
import 'package:furniture_store/common/widgets/layouts/grid_layout.dart';
import 'package:furniture_store/common/widgets/products/product_card_vertical.dart';
import 'package:furniture_store/features/home/controllers/product/all_products_controller.dart';
import 'package:furniture_store/features/home/model/product_model.dart';
import 'package:furniture_store/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

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
            decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
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
        SizedBox(
          height: TSizes.spaceBtwSections,
        ),
        Obx(() => GridLayout(
            itemCount: controller.products.length,
            itemBuilder: (__, index) =>
                ProductCardVerical(product: controller.products[index])))
      ],
    );
  }
}
