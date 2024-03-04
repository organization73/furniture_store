import 'package:flutter/material.dart';
import 'package:furniture_store/common/widgets/build_user_input_field.dart';
import 'package:furniture_store/common/widgets/cta_button.dart';
import 'package:furniture_store/features/personalization/controllers/user/update_name.dart';
import 'package:furniture_store/utils/constants/sizes.dart';
import 'package:furniture_store/utils/validators/validation.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ChangeNameScreen extends StatelessWidget {
  const ChangeNameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateNameController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Name'),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 70,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: BuildCTAButton(
            text: 'tContinue'.tr, onPressed: () => controller.updateUserName()),
      ),
      body: Padding(
        padding: EdgeInsets.all(TSizes.pagePaddingSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
                key: controller.updateNameFormKey,
                child: Column(
                  children: [
                    RoundedTextField(
                        'firstName'.tr,
                        controller.firstNameController,
                        prefixIcon: Iconsax.user,
                        keyboardType: TextInputType.name,
                        TValidator.validateUserInput),
                    SizedBox(height: TSizes.spaceBtwInputFields),
                    RoundedTextField(
                        prefixIcon: Iconsax.user,
                        'lastName'.tr,
                        controller.lastNameController,
                        keyboardType: TextInputType.name,
                        TValidator.validateUserInput),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
