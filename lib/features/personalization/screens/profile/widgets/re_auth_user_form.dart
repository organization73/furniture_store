import 'package:flutter/material.dart';
import 'package:decordash/common/widgets/build_user_input_field.dart';
import 'package:decordash/common/widgets/cta_button.dart';
import 'package:decordash/features/personalization/controllers/user/user_controller.dart';
import 'package:decordash/utils/constants/sizes.dart';
import 'package:decordash/utils/validators/validation.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ReAuthLoginForm extends StatelessWidget {
  const ReAuthLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Re-Authenticate User'),
        ),
        bottomNavigationBar: BottomAppBar(
          height: 70,
          color: Theme.of(context).scaffoldBackgroundColor,
          child: BuildCTAButton(
            text: 'Delete',
            onPressed: () {
              controller.reAuthEmailAndPasswordUser();
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(TSizes.pagePaddingSpace),
          child: Form(
              key: controller.reAuthFormKey,
              child: Column(
                children: [
                  RoundedTextField(
                      prefixIcon: Iconsax.direct_right_copy,
                      'email'.tr,
                      keyboardType: TextInputType.emailAddress,
                      controller.verifyEmail,
                      TValidator.validateEmail),
                  SizedBox(height: TSizes.spaceBtwInputFields),
                  Obx(() => RoundedTextField(
                      'password'.tr,
                      prefixIcon: Iconsax.password_check_copy,
                      suffixIcon: IconButton(
                          onPressed: () {
                            controller.hidePassword.value =
                                !controller.hidePassword.value;
                          },
                          icon: Icon(
                            controller.hidePassword.value
                                ? Iconsax.eye_copy
                                : Iconsax.eye_slash_copy,
                            size: TSizes.iconSm,
                          )),
                      controller.verifyPassword,
                      TValidator.validatePassword,
                      isPassword: controller.hidePassword.value)),
                  SizedBox(height: TSizes.spaceBtwInputFields),
                ],
              )),
        ));
  }
}
