import 'package:flutter/material.dart';
import 'package:decordashapp/common/widgets/input_fields/build_user_input_field.dart';
import 'package:decordashapp/common/widgets/buttons/cta_button.dart';
import 'package:decordashapp/modules/personalization/controllers/user/user_controller.dart';
import 'package:decordashapp/utils/constants/sizes.dart';
import 'package:decordashapp/utils/validators/validation.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

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
                      prefixIcon: IconsaxPlusLinear.direct_right,
                      'email'.tr,
                      keyboardType: TextInputType.emailAddress,
                      controller.verifyEmail,
                      TValidator.validateEmail),
                  const SizedBox(height: TSizes.spaceBtwInputFields),
                  Obx(() => RoundedTextField(
                      'password'.tr,
                      prefixIcon: IconsaxPlusLinear.password_check,
                      suffixIcon: IconButton(
                          onPressed: () {
                            controller.hidePassword.value =
                                !controller.hidePassword.value;
                          },
                          icon: Icon(
                            controller.hidePassword.value
                                ? IconsaxPlusLinear.eye
                                : IconsaxPlusLinear.eye_slash,
                            size: TSizes.iconSm,
                          )),
                      controller.verifyPassword,
                      TValidator.validatePassword,
                      isPassword: controller.hidePassword.value)),
                  const SizedBox(height: TSizes.spaceBtwInputFields),
                ],
              )),
        ));
  }
}
