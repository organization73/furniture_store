import 'package:decordash/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:decordash/common/widgets/images/circular_image.dart';
import 'package:decordash/common/widgets/texts/brand_title_text_with_verified_icon.dart';
import 'package:decordash/features/chat/screens/chat_screen.dart';
import 'package:decordash/features/favourits/controllers/favorite_controller.dart';
import 'package:decordash/features/home/widgets/sortable_withoutloadmore.dart';
import 'package:decordash/utils/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:decordash/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:decordash/features/home/controllers/vendor/vendor_controller.dart';
import 'package:decordash/features/home/model/vendor_model.dart';
import 'package:decordash/utils/constants/sizes.dart';
import 'package:decordash/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class VendorProductsScreen extends StatelessWidget {
  const VendorProductsScreen({super.key, required this.vendor});
  final VendorModel vendor;
  @override
  Widget build(BuildContext context) {
    final controller = VendorController.instance;
    Get.lazyPut(() => FavoriteController());

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.pagePaddingSpace),
          child: Column(
            children: [
              RoundedContainer(
                padding: const EdgeInsets.all(TSizes.sm),
                showBorder: true,
                backgroundColor: Colors.transparent,
                margin: EdgeInsets.only(bottom: TSizes.spaceBtwItems),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          child: CircularImage(
                            isNetworkImage: true,
                            imageUrl: vendor.image,
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                        SizedBox(
                          width: TSizes.spaceBtwItems / 2,
                        ),
                        SizedBox(
                          width: 0.7.sw,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  BrandTitleTextWithVerifiedIcon(
                                    vendor: vendor,
                                    beandtextSize: TextSizes.medium,
                                  ),
                                  Text(
                                    '${vendor.productsCount ?? 0} Products',
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
                                  ),
                                ],
                              ),
                              IconButton(
                                  onPressed: () {
                                    Get.to(
                                      () => ChatScreen(
                                        userId: vendor.id,
                                        vendor: vendor,
                                      ),
                                      duration:
                                          const Duration(milliseconds: 300),
                                      transition: Transition.rightToLeft,
                                    );
                                  },
                                  icon: const Icon(Iconsax.message))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: "Gallery Productss\n",
                          style: Theme.of(context).textTheme.headlineLarge),
                      TextSpan(
                          text: "You can apply filter to gallery products\n",
                          style: Theme.of(context).textTheme.bodyLarge),
                    ],
                  ),
                ),
              ),
              FutureBuilder(
                  future: controller.getVendorProducts(vendorId: vendor.id),
                  builder: (context, snapshot) {
                    const loader = VerticalProductShimmer();
                    final widget = TCloudHelperFunctions.checkMultiRecordState(
                        snapshot: snapshot, loader: loader);
                    if (widget != null) return widget;

                    final products = snapshot.data!;
                    return SortableProductsWithouTLoader(
                      products: products,
                      loadMoreProducts: () {},
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
