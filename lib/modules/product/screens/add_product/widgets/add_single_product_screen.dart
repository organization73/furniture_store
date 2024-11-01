import 'package:decordashapp/common/widgets/drop_down_menu/drop_down_menu.dart';
import 'package:decordashapp/common/widgets/input_fields/build_user_input_field.dart';
import 'package:decordashapp/modules/home/controllers/category_controller.dart';
import 'package:decordashapp/modules/product/screens/add_product/controllers/add_product_controller.dart';
import 'package:decordashapp/modules/product/screens/add_product/widgets/color_selection.dart';
import 'package:decordashapp/modules/product/screens/add_product/widgets/product_condition_selection.dart';
import 'package:decordashapp/modules/product/screens/add_product/widgets/product_image_upload.dart';
import 'package:decordashapp/modules/product/screens/add_product/widgets/product_stats_checkboxs.dart';
import 'package:decordashapp/utils/constants/sizes.dart';
import 'package:decordashapp/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddSingleProduct extends StatelessWidget {
  const AddSingleProduct({super.key});

  @override
  Widget build(BuildContext context) {
    final addController = Get.put(AddProductController());

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.all(TSizes.pagePaddingSpace),
            child: BuildProductImageUpload(),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: TSizes.pagePaddingSpace),
            child: Form(
              key: addController.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Product Category',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: BuildDropDown(
                          items: CategoryController.instance.allCatedories
                              .map((e) {
                            return e.name;
                          }).toList(),
                          onItemSelected: (selectedItem) {
                            addController.category = selectedItem;
                          },
                          hintText: 'Category',
                        ),
                      ),
                      const SizedBox(width: TSizes.sm),
                      Expanded(
                        child: BuildDropDown(
                          items: CategoryController.instance.allCatedories
                              .map((e) {
                            return e.name;
                          }).toList(),
                          onItemSelected: (selectedItem) {
                            addController.category = selectedItem;
                          },
                          hintText: 'Sub-Category',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  Text(
                    'productDetails'.tr,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  RoundedTextField(
                      'productName'.tr,
                      addController.nameController,
                      keyboardType: TextInputType.text,
                      TValidator.validateUserInput),
                  const SizedBox(height: TSizes.spaceBtwInputFields),
                  RoundedTextField(
                    'price'.tr,
                    addController.priceController,
                    keyboardType: TextInputType.phone,
                    (value) {
                      if (value == null || value.isEmpty) {
                        return 'priceVal'.tr;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: TSizes.spaceBtwInputFields),
                  RoundedTextField('address'.tr, addController.adressController,
                      (value) {
                    if (value == null || value.isEmpty) {
                      return 'addressVal'.tr;
                    }
                    return null;
                  }),
                  const SizedBox(height: TSizes.spaceBtwInputFields),
                  TextFormField(
                    controller: addController.descriptionController,
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
                  const SizedBox(height: TSizes.spaceBtwInputFields),
                  BuildDropDown(
                    items: [
                      'regular'.tr,
                      'zan'.tr,
                      'ablakash'.tr,
                    ],
                    onItemSelected: (selectedItem) {
                      addController.wood = selectedItem;
                    },
                    hintText: 'selectType'.tr,
                  ),
                  const SizedBox(height: TSizes.spaceBtwInputFields),
                  BuildDropDown(
                    items: [
                      'cotton'.tr,
                      'silk'.tr,
                    ],
                    onItemSelected: (selectedItem) {
                      addController.cloth = selectedItem;
                    },
                    hintText: 'selectType'.tr,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: TSizes.pagePaddingSpace),
            child: Text(
              'condition'.tr,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: TSizes.pagePaddingSpace),
            child: ConditionSelection(
              onOptionSelected: (int? selectedOption) {
                addController.condition = selectedOption!;
              },
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: TSizes.pagePaddingSpace),
            child: Text(
              'productcolor'.tr,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: ColorSelection(
              onColorSelected: (Color selectedColor) {
                addController.color = selectedColor;
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: TSizes.pagePaddingSpace),
            child: Text(
              'options'.tr,
              style: Theme.of(context).textTheme.titleMedium,
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
    );
  }
}
