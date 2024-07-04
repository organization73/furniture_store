import 'package:decordash/common/widgets/loaders/loaders.dart';
import 'package:decordash/common/widgets/shimmer/boxes_shimmer.dart';
import 'package:decordash/common/widgets/shimmer/list_tile_shimmer.dart';
import 'package:decordash/common/widgets/vendors/vendor_showcase.dart';
import 'package:decordash/data/repositories/vendor/vendor_repo.dart';
import 'package:decordash/features/home/model/vendor_model.dart';
import 'package:decordash/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:decordash/common/widgets/shimmer/shimmer_loader.dart';
import 'package:decordash/features/home/controllers/vendor/vendor_controller.dart';
import 'package:decordash/utils/constants/sizes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AllGalleriesPage extends StatefulWidget {
  const AllGalleriesPage({super.key});

  @override
  State<AllGalleriesPage> createState() => _AllGalleriesPageState();
}

class _AllGalleriesPageState extends State<AllGalleriesPage> {
  List<VendorModel> relist = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    VendorController.vendorsPageNumber = 2;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    VendorController.vendorsPageNumber = 2;
  }

  @override
  Widget build(BuildContext context) {
    final vendorController = VendorController.instance;

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: TSizes.pagePaddingSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: "Find Thousands of Products\n",
                          style: Theme.of(context).textTheme.bodyLarge),
                      TextSpan(
                          text: "Form Mulltiple Galleries",
                          style: Theme.of(context).textTheme.headlineLarge),
                    ],
                  ),
                ),
                SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
                Obx(() {
                  if (vendorController.isLoading.value) {
                    return const ShimmerLoaderEffect(
                      width: double.infinity,
                      height: 250,
                      raduis: 10,
                    );
                  }
                  if (vendorController.allVendors.isEmpty) {
                    return Center(child: Text('noData'.tr));
                  }
                  return ListView.separated(
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: TSizes.spaceBtwItems,
                      );
                    },
                    itemCount: vendorController.allVendors.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
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
                      return FutureBuilder(
                          future: vendorController.getVendorProducts(
                              vendorId: vendorController.allVendors[index].id,
                              limit: 3),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              final widget =
                                  TCloudHelperFunctions.checkMultiRecordState(
                                      snapshot: snapshot, loader: loader);
                              if (widget != null) return widget;
                            }

                            final products = snapshot.data!;
                            return VendorShowCase(
                              images:
                                  products.map((e) => e.productImage).toList(),
                              vendor: vendorController.allVendors[index],
                            );
                          });
                    },
                  );
                }),
                Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        final vendors = await VendorRepo.instance
                            .fetchAllVendors(
                                page: ++VendorController.vendorsPageNumber);
                        if (vendors.isEmpty) {
                          TLoaders.warningSnackBar(
                              title: "No more vendors",
                              message: "You have reached the end of the list");
                          return;
                        }
                        vendorController.allVendors.addAll(vendors);
                        // print("vvvvvvvvvvvvvvvv");
                        // print(VendorController.vendorsPageNumber);
                        // for (var e in vendors) {
                        //   print(e.name);
                        //   print(e.image);
                        //   print(e.location);
                        //   print(e.id);
                        //   print(e.productsCount);
                        // }
                        // print("vvvvvvvvvvvvvvveeeeee");
                      },
                      child: const Text('Load More'),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
