import 'package:decordash/common/widgets/loaders/loaders.dart';
import 'package:decordash/data/repositories/product/product_repo.dart';
import 'package:decordash/features/home/model/vendor_model.dart';
import 'package:decordash/features/personalization/controllers/user/user_controller.dart';
import 'package:decordash/features/product/model/product_model.dart';
import 'package:decordash/utils/helpers/network_manager.dart';
import 'package:decordash/utils/logging/logger.dart';
import 'package:decordash/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProductController extends GetxController {
  static AddProductController get instance => Get.find();

  final TextEditingController adressController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();
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

      TLoaders.errorSnackBar(title: 'ohSnap'.tr, message: e.toString());
    }
  }
}
