import 'package:decordashapp/common/widgets/shimmer/boxes_shimmer.dart';
import 'package:decordashapp/common/widgets/shimmer/list_tile_shimmer.dart';
import 'package:decordashapp/common/widgets/vendors/vendor_showcase.dart';
import 'package:decordashapp/modules/home/controllers/vendor/vendor_controller.dart';
import 'package:decordashapp/modules/home/model/category_model.dart';
import 'package:decordashapp/utils/constants/sizes.dart';
import 'package:decordashapp/utils/helpers/cloud_helper_functions.dart';
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
          var loader = const Column(
            children: [
              ListTileShimmer(),
              SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              BoxesShimmer(),
              SizedBox(
                height: TSizes.spaceBtwItems,
              ),
            ],
          );
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
                    future: controller.getVendorProducts(
                        vendorId: vendor.id, limit: 3),
                    builder: (context, snapshot) {
                      final widget =
                          TCloudHelperFunctions.checkMultiRecordState(
                              snapshot: snapshot, loader: loader);
                      if (widget != null) return widget;

                      final products = snapshot.data!;
                      return VendorShowCase(
                        images: products.map((e) => e.productImage).toList(),
                        vendor: vendor,
                      );
                    });
              });
        });
  }
}
