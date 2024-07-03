import 'package:decordash/common/widgets/shimmer/boxes_shimmer.dart';
import 'package:decordash/common/widgets/shimmer/list_tile_shimmer.dart';
import 'package:decordash/common/widgets/vendors/vendor_showcase.dart';
import 'package:decordash/features/home/controllers/vendor/vendor_controller.dart';
import 'package:decordash/features/home/model/category_model.dart';
import 'package:decordash/utils/constants/sizes.dart';
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
          var loader = Column(
            children: [
              const ListTileShimmer(),
              SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              const BoxesShimmer(),
              SizedBox(
                height: TSizes.spaceBtwItems,
              ),
            ],
          );
          if (!snapshot.hasData) {
            final widget = TCloudHelperFunctions.checkMultiRecordState(
                snapshot: snapshot, loader: loader);
            if (widget != null) return widget;
          }
          final vendors = snapshot.data!;
          return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: vendors.length,
              itemBuilder: (_, index) {
                final vendor = vendors[index];
                return FutureBuilder(
                    future: controller.getVendorProducts(
                        vendorId: vendor.id, limit: 15),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        final widget =
                            TCloudHelperFunctions.checkMultiRecordState(
                                snapshot: snapshot, loader: loader);
                        if (widget != null) return widget;
                      }
                      var products = snapshot.data!;
                      products = products.where((element) {
                        if (category.id == '1' &&
                            (element.categoryId == "11" ||
                                element.categoryId == "12")) return true;
                        if (category.id == '2' &&
                            (element.categoryId == "21")) {
                          return true;
                        }
                        if (category.id == '3' &&
                            (element.categoryId == "31")) {
                          return true;
                        }
                        if (category.id == '4' &&
                            (element.categoryId == "41")) {
                          return true;
                        }

                        return element.categoryId == category.id;
                      }).toList();
                      if (products.isEmpty) {
                        return const SizedBox();
                      }
                      if (products.length > 4) {
                        products = products.take(4).toList();
                      }
                      return VendorShowCase(
                        images: products.map((e) => e.productImage).toList(),
                        vendor: vendor,
                      );
                    });
              });
        });
  }
}
