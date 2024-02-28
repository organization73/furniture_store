import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furniture_store/common/widgets/build_user_input_field.dart';
import 'package:furniture_store/common/widgets/color_selection.dart';
import 'package:furniture_store/common/widgets/drop_down_menu.dart';
import 'package:furniture_store/common/widgets/product_condition_selection.dart';
import 'package:furniture_store/common/widgets/product_image_upload.dart';
import 'package:furniture_store/features/product/screens/add_product/widgets/product_stats_checkboxs.dart';
import 'package:furniture_store/utils/constants/sizes.dart';
import 'package:furniture_store/utils/validators/validation.dart';
import 'package:get/get.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final List<String> pickedImagePaths = [];
  bool isSelected = false;

  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  final _formKey = GlobalKey<FormState>();

  TextEditingController adressController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  void dispose() {
    adressController.dispose();
    descriptionController.dispose();
    priceController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    if (pickedImagePaths.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Theme.of(context).colorScheme.error,
                        content: Text(
                          'imageUpVal'.tr,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onError),
                        ),
                        duration: const Duration(milliseconds: 1500),
                      ));
                    }
                    if ((_formKey.currentState?.validate() ?? false) &
                        (pickedImagePaths.isNotEmpty)) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.green,
                        content: Text('done'.tr),
                        duration: const Duration(milliseconds: 1500),
                      ));
                    }
                  },
                  icon: const Icon(Icons.add))
            ],
            title: Text(
              'addProduct'.tr,
            )),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: BuildProductImageUpload(
                      pickedImagePaths: pickedImagePaths),
                ),
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
                    key: _formKey,
                    child: Column(
                      children: [
                        RoundedTextField(
                            'productName'.tr,
                            nameController,
                            keyboardType: TextInputType.text,
                            TValidator.validateUserInput),
                        SizedBox(height: TSizes.spaceBtwInputFields),
                        RoundedTextField(
                          'price'.tr,
                          priceController,
                          keyboardType: TextInputType.phone,
                          (value) {
                            if (value == null || value.isEmpty) {
                              return 'priceVal'.tr;
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: TSizes.spaceBtwInputFields),
                        RoundedTextField('address'.tr, adressController,
                            (value) {
                          if (value == null || value.isEmpty) {
                            return 'addressVal'.tr;
                          }
                          return null;
                        }),
                        SizedBox(height: TSizes.spaceBtwInputFields),
                        TextFormField(
                          controller: descriptionController,
                          maxLines: 4,
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
                          items: [
                            'regular'.tr,
                            'zan'.tr,
                            'ablakash'.tr,
                          ],
                          onItemSelected: (selectedItem) {},
                          hintText: 'selectType'.tr,
                        ),
                        SizedBox(height: TSizes.spaceBtwInputFields),
                        BuildDropDown(
                          items: [
                            'cotton'.tr,
                            'silk'.tr,
                          ],
                          onItemSelected: (selectedItem) {},
                          hintText: 'selectType'.tr,
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
                      // Handle the selected option here
                      // print('Selected option: $selectedOption');
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
                  padding: const EdgeInsets.only(left: 15),
                  child: ColorSelection(
                    onColorSelected: (Color selectedColor) {
                      // Handle the selected color here
                      // print('Selected color: $selectedColor');
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
  }
}
