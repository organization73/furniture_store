import 'dart:math';

import 'package:decordash/data/repositories/authentication/api_services.dart';
import 'package:decordash/features/product/model/product_model.dart';
import 'package:decordash/features/product/screens/add_product/controllers/add_product_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:decordash/common/widgets/input_fields/build_user_input_field.dart';
import 'package:decordash/features/product/screens/add_product/widgets/color_selection.dart';
import 'package:decordash/common/widgets/drop_down_menu/drop_down_menu.dart';
import 'package:decordash/features/product/screens/add_product/widgets/product_condition_selection.dart';
import 'package:decordash/features/product/screens/add_product/widgets/product_image_upload.dart';
import 'package:decordash/features/product/screens/add_product/widgets/product_stats_checkboxs.dart';
import 'package:decordash/utils/constants/sizes.dart';
import 'package:decordash/utils/validators/validation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class EditProductScreen extends StatelessWidget {
  const EditProductScreen(
      {super.key, required this.productId, required this.editedProduct});
  final String productId;
  final ProductModel editedProduct;
  @override
  Widget build(BuildContext context) {
    final addController = Get.put(AddProductController());
    return Scaffold(
      body: FutureBuilder(
          future: HttpService.instance
              .getOneProducts(productId, GetStorage().read('token')),
          builder: (context, snapShot) {
            if (snapShot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapShot.hasError) {
              return const Center(
                child: Text('Error'),
              );
            }
            if (snapShot.hasData) {
              AddProductController.instance.nameController.text =
                  snapShot.data!['title'];

              AddProductController.instance.priceController.text =
                  (snapShot.data!['price']).toString();
              AddProductController.instance.descriptionController.text =
                  snapShot.data!['description'];
              AddProductController.instance.wood =
                  snapShot.data!['details']['wood'];
              AddProductController.instance.cloth =
                  snapShot.data!['details']['cloth'];
              AddProductController.instance.condition =
                  snapShot.data!['details']['condition'] == 'new' ? 0 : 1;

              String colorString = "${snapShot.data!['details']['color']}";

              String valueString =
                  colorString.split('(0x')[1].split(')')[0]; // 0xff70c04f
              int value = int.parse(valueString, radix: 16);

              // Create a Color object
              Color color = Color(value);

              AddProductController.instance.color = color;
              AddProductController.instance.pickedImagePaths.value =
                  ((snapShot.data!['images']) as List<dynamic>)
                      .map((e) => (e['imageUrl']).toString())
                      .toList();
              AddProductController.instance.productStats.value = {
                "delivery": snapShot.data!['details']['delevary'],
                "negotioate": snapShot.data!['details']['negotiable'],
                "modify": snapShot.data!['details']['modefiable']
              };
            }
            return Scaffold(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                appBar: AppBar(
                    actions: [
                      IconButton(
                          onPressed: () => addController.editProduct(
                              id: productId, Editingproduct: editedProduct),
                          icon: const Icon(Icons.edit))
                    ],
                    title: const Text(
                      'Edit Product',
                    )),
                body: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            'productDetails'.tr,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Form(
                            key: addController.formKey,
                            child: Column(
                              children: [
                                RoundedTextField(
                                    'productName'.tr,
                                    addController.nameController,
                                    keyboardType: TextInputType.text,
                                    TValidator.validateUserInput),
                                SizedBox(height: TSizes.spaceBtwInputFields),
                                RoundedTextField(
                                  'price'.tr,
                                  addController.priceController,
                                  keyboardType: TextInputType.phone,
                                  (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'priceVal'.tr;
                                    }
                                    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                                      return 'Invalid Price';
                                    }
                                    if (value.length > 9) {
                                      return "Invalid Price";
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: TSizes.spaceBtwInputFields),
                                TextFormField(
                                  controller:
                                      addController.descriptionController,
                                  maxLines: 4,
                                  maxLength: 85,
                                  decoration: InputDecoration(
                                    hintText: 'description'.tr,
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'descriptionVal'.tr;
                                    }

                                    return null;
                                  },
                                ),
                                SizedBox(height: TSizes.spaceBtwInputFields),
                                BuildDropDown(
                                  items: const [
                                    'Oak',
                                    'Mahogany',
                                    'Pine',
                                    'Birch',
                                    'Maple',
                                    'Cherry',
                                    'Walnut',
                                    'Cedar',
                                  ],
                                  onItemSelected: (selectedItem) {
                                    addController.wood = selectedItem;
                                  },
                                  hintText: 'Select Wood',
                                ),
                                SizedBox(height: TSizes.spaceBtwInputFields),
                                BuildDropDown(
                                  items: const [
                                    'Cotton',
                                    'Leather',
                                    'Polyester',
                                    'Velvet',
                                    'Silk',
                                    'Linen',
                                    'Wool',
                                    'Nylon',
                                  ],
                                  onItemSelected: (selectedItem) {
                                    addController.cloth = selectedItem;
                                  },
                                  hintText: 'Select Cloth Type',
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            'condition'.tr,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: ConditionSelection(
                            onOptionSelected: (int? selectedOption) {
                              addController.condition = selectedOption!;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            'productcolor'.tr,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: ColorSelection(
                            onColorSelected: (Color selectedColor) {
                              addController.color = selectedColor;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            'options'.tr,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),
                        ProductStatsCheckboxes(
                          productStats: {
                            'delivery'.tr: false,
                            'negotioate'.tr: false,
                            'modify'.tr: false,
                          },
                        ),
                      ],
                    ),
                  ),
                ));
          }),
    );
  }
}
