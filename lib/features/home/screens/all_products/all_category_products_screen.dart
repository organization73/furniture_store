import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decordash/common/widgets/loaders/loaders.dart';
import 'package:decordash/data/repositories/product/product_repo.dart';
import 'package:decordash/features/home/controllers/category_controller.dart';
import 'package:flutter/material.dart';
import 'package:decordash/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:decordash/features/home/controllers/product/all_products_controller.dart';
import 'package:decordash/features/product/model/product_model.dart';
import 'package:decordash/features/home/widgets/sortable_products.dart';
import 'package:decordash/utils/constants/sizes.dart';
import 'package:decordash/utils/helpers/cloud_helper_functions.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class AllCatergoryProductsScreen extends StatefulWidget {
  const AllCatergoryProductsScreen(
      {super.key, required this.title, this.query, this.futureMethod});
  final String title;
  final Query? query;
  final Future<List<ProductModel>>? futureMethod;

  @override
  State<AllCatergoryProductsScreen> createState() =>
      _AllCatergoryProductsScreenState();
}

class _AllCatergoryProductsScreenState
    extends State<AllCatergoryProductsScreen> {
  @override
  Widget build(BuildContext context) {
    final controllerCa = CategoryController.instance;
    final controller = Get.put(AllProductsController());
    final title = widget.title;
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
                    print(title);
                    var clas = '11';
                    if (title == "Wooden Chairs") {
                      clas = '11';
                    } else if (title == "Swivle Chairs") {
                      clas = '12';
                    } else if (title == "Couches") {
                      clas = '21';
                    } else if (title == "Regular Beds") {
                      clas = '31';
                    } else if (title == "wooden Tables") {
                      clas = '41';
                    }
                    print("loaddded more categories products");
                    print(clas);
                    try {
                      var p = await controllerCa.getCategoryProducts(
                          categoryId: clas, limit: -1,page: ++ProductRepo.pagenumber);
                      // var p = await ProductRepo.instance
                      //     .fetchProductsFromServer(++ProductRepo.pagenumber);
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
