import 'package:decordash/common/widgets/loaders/loaders.dart';
import 'package:decordash/data/repositories/product/product_repo.dart';
import 'package:decordash/features/home/model/vendor_model.dart';
import 'package:decordash/features/personalization/controllers/user/user_controller.dart';
import 'package:decordash/features/product/model/product_model.dart';
import 'package:decordash/utils/helpers/network_manager.dart';
import 'package:decordash/utils/http/http_client.dart';
import 'package:decordash/utils/logging/logger.dart';
import 'package:decordash/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AddProductController extends GetxController {
  static AddProductController get instance => Get.find();

  final TextEditingController adressController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  static ProductModel nestedProducrt = ProductModel.empty();
  int? condition;
  Color? color;
  String? wood;
  String? cloth;

  final userController = Get.put(UserController());

  final RxMap<String, bool> productStats = {
    'delivery'.tr: false,
    'negotioate'.tr: false,
    'modify'.tr: false,
  }.obs;

  RxList<String> pickedImagePaths = <String>[].obs;

  Future<void> addProduct() async {
    try {
      FullScreenLoader.openLoadingDialog(
          'processingLoading'.tr, 'assets/animations/animation-of-docer.json');

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        TLoaders.warningSnackBar(
            title: 'internet'.tr, message: 'noInternet'.tr);
        return;
      }
      if (pickedImagePaths.isEmpty) {
        FullScreenLoader.stopLoading();
        TLoaders.warningSnackBar(
          title: 'Warning',
          message: 'imageUpVal'.tr,
        );
        return;
      }

      if (!formKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }
      if (condition == null) {
        FullScreenLoader.stopLoading();
        TLoaders.warningSnackBar(
            title: 'Warning', message: 'Please choose conditions');
        return;
      }
      if (color == null) {
        FullScreenLoader.stopLoading();
        TLoaders.warningSnackBar(
            title: 'Warning', message: 'Please choose color');
        return;
      }

      final newProduct = ProductModel(
        productName: nameController.text,
        categoryId: '1',
        productPrice: double.parse(priceController.text),
        productImage: pickedImagePaths[0],
        productDetails: ProductDetails(
          condition: condition == 1 ? 'used' : 'new',
          color: color.toString(),
          productListImages: pickedImagePaths,
          productSpecs: {
            'ablakash': wood ?? '',
            'fabric type': cloth ?? '',
          },
          productDesc: descriptionController.text,
          productStats: ProductStats(
            delivery: productStats.values.elementAt(0),
            negotiable: productStats.values.elementAt(1),
            modifiable: productStats.values.elementAt(2),
          ),
          productSeller: VendorModel.empty(),
        ),
      );
      nestedProducrt = newProduct;
      await ProductRepo.instance.uploadProductToDatabase(newProduct);
////////////////////////////////////////////
      FullScreenLoader.stopLoading();

      TLoaders.successSnackBar(
        title: 'congrats'.tr,
        message: 'done'.tr,
      );
    } catch (e) {
      FullScreenLoader.stopLoading();
      LoggerHelper.error(e.toString());
      if (e.toString() ==
          "Exception: Image classification confidence is too low") {
        // Show a popup to ask for report or not
        // You can use a dialog or a snackbar to display the popup
        // Here's an example using GetX library's Get.dialog() method

        Get.dialog(
          AlertDialog(
            title: const Text('Low Confidence'),
            content: const Text(
                'Image classification confidence is too low. Do you want to report this?'),
            actions: [
              TextButton(
                onPressed: () async {
                  Get.back(); // Close the dialog

                  FullScreenLoader.openLoadingDialog('processingLoading'.tr,
                      'assets/animations/animation-of-docer.json');

                  await ProductRepo.instance
                      .uploadProductToDatabase(nestedProducrt);

                  // Handle the user's choice to report
                  var m = {
                    "appellation": true,
                    "title": nestedProducrt.productName,
                    "price": nestedProducrt.productPrice,
                    "description": nestedProducrt.productDetails.productDesc,
                    "images": nestedProducrt.productDetails.productListImages,
                    "details": {
                      "wood": nestedProducrt
                          .productDetails.productSpecs['ablakash'],
                      "abalakach": "your ablakash here",
                      "cloth": nestedProducrt
                          .productDetails.productSpecs['fabric type'],
                      "condition": nestedProducrt.productDetails.condition,
                      "color": nestedProducrt.productDetails.color,
                      "delevary":
                          nestedProducrt.productDetails.productStats.delivery,
                      "negotiable":
                          nestedProducrt.productDetails.productStats.negotiable,
                      "modefiable":
                          nestedProducrt.productDetails.productStats.modifiable,
                    }
                  };
                  print('--------------');
                  print(m);
                  String t = GetStorage().read('token');
                  try {
                    var w = await THttpHelper.postBearerAuth(
                        'product/create-product', t, m);
                    print(w.body);
                    TLoaders.successSnackBar(title: "Report Sent Successfully");
                    FullScreenLoader
                        .stopLoading(); // Add your code here to handle the reporting logic
                  } catch (e) {
                    FullScreenLoader
                        .stopLoading(); // Add your code here to handle the reporting logic
                  }
                },
                child: const Text('Report'),
              ),
              TextButton(
                onPressed: () {
                  // Handle the user's choice not to report
                  Get.back(); // Close the dialog
                  // Add your code here to handle the logic when the user chooses not to report
                },
                child: const Text('Don\'t Report'),
              ),
            ],
          ),
        );
      }
      TLoaders.errorSnackBar(title: 'ohSnap'.tr, message: e.toString());
    }
  }
}
