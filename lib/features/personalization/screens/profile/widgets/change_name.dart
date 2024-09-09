import 'package:flutter/material.dart';
import 'package:decordashapp/common/widgets/input_fields/build_user_input_field.dart';
import 'package:decordashapp/common/widgets/buttons/cta_button.dart';
import 'package:decordashapp/features/personalization/controllers/user/update_name.dart';
import 'package:decordashapp/utils/constants/sizes.dart';
import 'package:decordashapp/utils/validators/validation.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

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
        color: Theme.of(context).scaffoldBackgroundColor,
        child: BuildCTAButton(
            text: 'tContinue'.tr,
            onPressed: () {
              controller.updateUserName();
            }),
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.pagePaddingSpace),
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
                        prefixIcon: Iconsax.user_copy,
                        keyboardType: TextInputType.name,
                        TValidator.validateUserInput),
                    const SizedBox(height: TSizes.spaceBtwInputFields),
                    RoundedTextField(
                        prefixIcon: Iconsax.user_copy,
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
