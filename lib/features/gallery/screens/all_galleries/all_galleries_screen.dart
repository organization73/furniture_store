import 'package:flutter/material.dart';
import 'package:decordash/common/widgets/shimmer/shimmer_loader.dart';
import 'package:decordash/features/gallery/screens/all_galleries/widgets/gallery_card.dart';
import 'package:decordash/features/home/controllers/vendor/vendor_controller.dart';
import 'package:decordash/utils/constants/sizes.dart';
import 'package:get/get.dart';

class AllGalleriesPage extends StatelessWidget {
  const AllGalleriesPage({super.key});

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
                      return GalleryCard(
                        vendor: vendorController.allVendors[index],
                      );
                    },
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
