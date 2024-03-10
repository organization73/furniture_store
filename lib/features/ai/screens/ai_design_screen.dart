import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:decordash/common/widgets/ai_banner.dart';
import 'package:decordash/common/widgets/drop_down_menu.dart';
import 'package:decordash/features/ai/controllers/generative_ai/generative_ai_controller.dart';
import 'package:decordash/features/ai/widgets/generative_image.dart';
import 'package:decordash/features/ai/model/generative_ai/balance_model.dart';
import 'package:decordash/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class AiPage extends StatefulWidget {
  const AiPage({super.key});

  @override
  State<AiPage> createState() => _AiPageState();
}

class _AiPageState extends State<AiPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController aiDescriptionController;
  final BalanceModel balanceModel = BalanceModel();

  @override
  void initState() {
    super.initState();
    aiDescriptionController = TextEditingController();
  }

  @override
  void dispose() {
    aiDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final balanceController = Get.put(BalanceController());
    // TODO fix this shit
    // balanceController.fetchBalance();

    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          title: Text(
            'aiDesigns'.tr,
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AiInfoCard(
                    title: 'myPoints'.tr,
                    onMoreTap: () {},
                    subIcon: CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      radius: 20,
                      child: const Icon(
                        Iconsax.money_recive,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  BuildDropDown(
                    title: 'categories'.tr,
                    items: ['bedRoom'.tr, 'dinRoom'.tr, 'officeRoom'.tr],
                    onItemSelected: (selectedItem) {},
                    hintText: 'selectType'.tr,
                  ),
                  SizedBox(
                    height: TSizes.spaceBtwInputFields,
                  ),
                  BuildDropDown(
                    title: 'subCat'.tr,
                    items: ['chairsCat'.tr, 'sofaCat'.tr, 'desksCat'.tr],
                    onItemSelected: (selectedItem) {},
                    hintText: 'selectType'.tr,
                  ),
                  SizedBox(
                    height: TSizes.spaceBtwInputFields,
                  ),
                  Text(
                    'prompt'.tr,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: aiDescriptionController,
                          maxLines: 4,
                          decoration: InputDecoration(
                            hintText: 'prompt'.tr,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Fill the prompt';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: TSizes.spaceBtwInputFields,
                  ),
                  ImageGenerator(
                      descriptionController: aiDescriptionController),
                ],
              ),
            ),
          ),
        ));
  }
}
