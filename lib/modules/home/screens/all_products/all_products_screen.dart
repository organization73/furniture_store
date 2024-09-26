import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:decordashapp/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:decordashapp/modules/home/controllers/product/all_products_controller.dart';
import 'package:decordashapp/modules/product/model/product_model.dart';
import 'package:decordashapp/modules/home/widgets/sortable_products.dart';
import 'package:decordashapp/utils/constants/sizes.dart';
import 'package:decordashapp/utils/helpers/cloud_helper_functions.dart';
import 'package:get/get.dart';

class AllProductsScreen extends StatelessWidget {
  const AllProductsScreen(
      {super.key, required this.title, this.query, this.futureMethod});
  final String title;
  final Query? query;
  final Future<List<ProductModel>>? futureMethod;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductsController());
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: TSizes.pagePaddingSpace),
          child: FutureBuilder(
              future: futureMethod ?? controller.fetchProductsByQuery(query),
              builder: (context, snapshot) {
                const loader = VerticalProductShimmer();
                final widget = TCloudHelperFunctions.checkMultiRecordState(
                    snapshot: snapshot, loader: loader);
                if (widget != null) return widget;

                final products = snapshot.data!;
                return SortableProducts(
                  products: products,
                );
              }),
        ),
      ),
    );
  }
}
