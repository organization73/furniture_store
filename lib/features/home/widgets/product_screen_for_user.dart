import 'package:cached_network_image/cached_network_image.dart';
import 'package:decordash/common/widgets/appbar/custom_appbar.dart';
import 'package:decordash/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:decordash/common/widgets/products/favourite_icon/favourite_icon.dart';
import 'package:decordash/common/widgets/products/favourite_icon/report_icon.dart';
import 'package:decordash/features/home/controllers/product/images_controller.dart';
import 'package:decordash/features/home/screens/home_screen.dart';
import 'package:decordash/features/home/screens/nav_menu.dart';
import 'package:decordash/features/personalization/screens/settings/settings.dart';
import 'package:decordash/features/product/screens/add_product/controllers/add_product_controller.dart';
import 'package:decordash/features/product/screens/add_product/widgets/edit_product_screen.dart';
import 'package:decordash/features/store/screens/store_screen.dart';
import 'package:flutter/material.dart';

import 'package:decordash/common/widgets/icons/circular_icon.dart';
import 'package:decordash/common/widgets/loaders/loaders.dart';
import 'package:decordash/utils/http/http_client.dart';
import 'package:decordash/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:decordash/features/home/controllers/product/all_products_controller.dart';
import 'package:decordash/features/product/model/product_model.dart';
import 'package:decordash/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:decordash/common/styles/shadows.dart';
import 'package:decordash/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:decordash/common/widgets/images/rounded_image.dart';
import 'package:decordash/common/widgets/texts/brand_title_text_with_verified_icon.dart';
import 'package:decordash/common/widgets/texts/product_price_text.dart';
import 'package:decordash/common/widgets/texts/product_title_text.dart';
import 'package:decordash/features/home/controllers/product/product_controller.dart';
import 'package:decordash/features/chat/screens/chat_screen.dart';
import 'package:decordash/features/product/screens/product_details/widgets/product_image_slider.dart';
import 'package:decordash/features/product/screens/product_details/widgets/product_meta_data.dart';
import 'package:decordash/features/product/screens/product_details/widgets/product_rating_container.dart';


class ProductDetailsScreenForUser extends StatelessWidget {
  const ProductDetailsScreenForUser({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: ElevatedButton(
          child: Text(
            'contactSeller'.tr,
          ),
          onPressed: () {
            Get.to(
              () => ChatScreen(
                userId: product.productDetails.productSeller.id,
                vendor: product.productDetails.productSeller,
              ),
              duration: const Duration(milliseconds: 300),
              transition: Transition.rightToLeft,
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProductImageSlider(
              product: product,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  right: TSizes.pagePaddingSpace,
                  left: TSizes.pagePaddingSpace,
                  bottom: TSizes.pagePaddingSpace),
              child: Column(
                children: [
                  RatingWidget(
                    product: product,
                  ),
                  SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  ProductMetaData(
                    product: product,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ProductImageSlider extends StatelessWidget {
  const ProductImageSlider({
    super.key,
    required this.product,
  });
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ImageController());
    final images = controller.getAllProductImages(product);
    return CurvedEdgesWidget(
        child: Container(
      color: Theme.of(context).colorScheme.surfaceContainer,
      child: Stack(
        children: [
          SizedBox(
              height: 400,
              child: Padding(
                padding: const EdgeInsets.all(TSizes.productImageRadius * 2),
                child: Center(
                  child: Obx(() {
                    final image = controller.selectedProductImage.value;
                    return GestureDetector(
                      onTap: () => controller.showEnlargedImage(image),
                      child: CachedNetworkImage(
                        imageUrl: image,
                        progressIndicatorBuilder: (_, __, progress) =>
                            CircularProgressIndicator(
                          value: progress.progress,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    );
                  }),
                ),
              )),
          Positioned(
            right: 0,
            bottom: 30,
            left: TSizes.defaultSpace,
            child: SizedBox(
              height: 80,
              child: ListView.separated(
                itemBuilder: (_, index) => Obx(
                  () {
                    final imageSelected =
                        controller.selectedProductImage.value == images[index];
                    return RoundedImage(
                        width: 80,
                        onPress: () => controller.selectedProductImage.value =
                            images[index],
                        isNetworkImage: true,
                        border: Border.all(
                            color: imageSelected
                                ? Theme.of(context).colorScheme.primary
                                : Colors.transparent),
                        padding: const EdgeInsets.all(TSizes.sm),
                        backgroundColor: Theme.of(context).colorScheme.surface,
                        imageUrl: images[index]);
                  },
                ),
                separatorBuilder: (_, __) => SizedBox(
                  width: TSizes.spaceBtwItems,
                ),
                itemCount: images.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: const AlwaysScrollableScrollPhysics(),
              ),
            ),
          ),
          CustomAppBar(
            showBackArrow: true,
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: TSizes.sm),
                child: EditProduct(
                  editProduct: product,
                  productId: product.id,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: TSizes.sm),
                child: DeleteProduct(
                  productId: product.id,
                ),
              )
            ],
          )
        ],
      ),
    ));
  }
}

class DeleteProduct extends StatelessWidget {
  const DeleteProduct({super.key, required this.productId});
  final String productId;
  @override
  Widget build(BuildContext context) {
    return CicularIcon(
      width: 35.r,
      height: 35.r,
      icon: Iconsax.pen_remove,
      color: Theme.of(context).colorScheme.error,
      onPress: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Delete Product'),
              content:
                  const Text('Are you sure you want to Delete this product?'),
              actions: [
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('Delete'),
                  onPressed: () async {
                    // Perform the report action here
                    Navigator.of(context).pop();
                    FullScreenLoader.openLoadingDialog("Deleting",
                        'assets/animations/animation-of-docer.json');
                    try {
                      // print("1");
                      var r = await THttpHelper.deleteBearerAuth(
                          "product/delete-product",
                          GetStorage().read("token"),
                          {"productId": productId});
                      // print(r.body);
                      // print("2");
                      FullScreenLoader.stopLoading();

                      Get.offAll(
                        () => const NavMenu(),
                        duration: const Duration(milliseconds: 300),
                        transition: Transition.rightToLeft,
                      );
                      TLoaders.successSnackBar(title: "Deleted Successfully");
                      print("3");
                    } catch (e) {
                      FullScreenLoader.stopLoading();
                      TLoaders.errorSnackBar(
                          title:
                              "error happing while tring to delete, please try again");
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class EditProduct extends StatelessWidget {
  const EditProduct(
      {super.key, required this.productId, required this.editProduct});
  final String productId;
  final ProductModel editProduct;
  @override
  Widget build(BuildContext context) {
    return CicularIcon(
      width: 35.r,
      height: 35.r,
      icon: Iconsax.edit,
      onPress: () {
        Get.to(
          () => EditProductScreen(
            productId: productId,
            editedProduct: editProduct,
          ),
          duration: const Duration(milliseconds: 300),
          transition: Transition.rightToLeft,
        );
      },
    );
  }
}
