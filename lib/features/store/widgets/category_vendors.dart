import 'package:decordash/common/widgets/vendors/vendor_showcase.dart';
import 'package:decordash/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:decordash/features/home/controllers/vendor/vendor_controller.dart';
import 'package:decordash/features/home/model/category_model.dart';
import 'package:decordash/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';

class CategoryVendors extends StatelessWidget {
  const CategoryVendors({super.key, required this.category});
  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = VendorController.instance;
    return FutureBuilder(
        future: controller.getVendorsForCategory(category.id),
        builder: (context, snapshot) {
          const loader = VerticalProductShimmer();
          final widget = TCloudHelperFunctions.checkMultiRecordState(
              snapshot: snapshot, loader: loader);
          if (widget != null) return widget;

          final vendors = snapshot.data!;
          return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: vendors.length,
              itemBuilder: (_, index) {
                final vendor = vendors[index];
                return FutureBuilder(
                    future: controller.getVendorProducts(vendorId: vendor.id,limit: 3),
                    builder: (context, snapshot) {
                        const loader = VerticalProductShimmer();
          final widget = TCloudHelperFunctions.checkMultiRecordState(
              snapshot: snapshot, loader: loader);
          if (widget != null) return widget;

          final products = snapshot.data!;
                      return VendorShowCase(
                        images:products.map((e) => e.productImage).toList(),
                        vendor: vendor,
                      );
                    });
              });
        });
  }
}
