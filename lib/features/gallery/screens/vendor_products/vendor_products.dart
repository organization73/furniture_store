import 'package:flutter/material.dart';
import 'package:decordashapp/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:decordashapp/features/home/controllers/vendor/vendor_controller.dart';
import 'package:decordashapp/features/home/model/vendor_model.dart';
import 'package:decordashapp/features/home/widgets/sortable_products.dart';
import 'package:decordashapp/utils/constants/sizes.dart';
import 'package:decordashapp/utils/helpers/cloud_helper_functions.dart';

class VendorProductsScreen extends StatelessWidget {
  const VendorProductsScreen({super.key, required this.vendor});
  final VendorModel vendor;
  @override
  Widget build(BuildContext context) {
    final controller = VendorController.instance;
    return Scaffold(
      appBar: AppBar(
        title: Text(vendor.name),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.pagePaddingSpace),
          child: Column(
            children: [
              FutureBuilder(
                  future: controller.getVendorProducts(vendorId: vendor.id),
                  builder: (context, snapshot) {
                    const loader = VerticalProductShimmer();
                    final widget = TCloudHelperFunctions.checkMultiRecordState(
                        snapshot: snapshot, loader: loader);
                    if (widget != null) return widget;

                    final products = snapshot.data!;
                    return SortableProducts(products: products);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
