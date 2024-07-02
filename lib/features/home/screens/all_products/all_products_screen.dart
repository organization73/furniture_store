import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decordash/common/widgets/loaders/loaders.dart';
import 'package:decordash/data/repositories/product/product_repo.dart';
import 'package:flutter/material.dart';
import 'package:decordash/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:decordash/features/home/controllers/product/all_products_controller.dart';
import 'package:decordash/features/product/model/product_model.dart';
import 'package:decordash/features/home/widgets/sortable_products.dart';
import 'package:decordash/utils/constants/sizes.dart';
import 'package:decordash/utils/helpers/cloud_helper_functions.dart';
import 'package:get/get.dart';

class AllProductsScreen extends StatefulWidget {
  const AllProductsScreen(
      {super.key, required this.title, this.query, this.futureMethod});
  final String title;
  final Query? query;
  final Future<List<ProductModel>>? futureMethod;

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductsController());
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: TSizes.pagePaddingSpace),
          child: FutureBuilder(
              future: widget.futureMethod ??
                  controller.fetchProductsByQuery(widget.query),
              builder: (context, snapshot) {
                const loader = VerticalProductShimmer();
                final widget = TCloudHelperFunctions.checkMultiRecordState(
                    snapshot: snapshot, loader: loader);
                if (widget != null) return widget;

                final products = snapshot.data!;
                return SortableProducts(
                  products: products,
                  loadMoreProducts: () async {
                    print("loaddded more");
                    try {
                      var p = await ProductRepo.instance
                          .fetchProductsFromServer(++ProductRepo.pagenumber);
                      setState(() {
                        if (p.isEmpty) {
                          TLoaders.warningSnackBar(
                              title: "loading",
                              message: "No more products to load");
                        }
                        products.addAll(p);
                      });
                    } catch (e) {
                      TLoaders.warningSnackBar(
                          title: "Error loading more products",
                          message: "No more products to load");
                    }
                  },
                );
              }),
        ),
      ),
    );
  }
}
