import 'package:flutter/material.dart';
import 'package:furniture_store/common/widgets/build_user_input_field.dart';
import 'package:furniture_store/common/widgets/cta_button.dart';
import 'package:furniture_store/features/personalization/controllers/user/user_controller.dart';
import 'package:furniture_store/utils/constants/sizes.dart';
import 'package:furniture_store/utils/validators/validation.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

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
          padding: EdgeInsets.all(TSizes.pagePaddingSpace),
          child: Form(
              key: controller.reAuthFormKey,
              child: Column(
                children: [
                  RoundedTextField(
                      prefixIcon: Iconsax.direct_right,
                      'email'.tr,
                      keyboardType: TextInputType.emailAddress,
                      controller.verifyEmail,
                      TValidator.validateEmail),
                  SizedBox(height: TSizes.spaceBtwInputFields),
                  Obx(() => RoundedTextField(
                      'password'.tr,
                      prefixIcon: Iconsax.password_check,
                      suffixIcon: IconButton(
                          onPressed: () {
                            controller.hidePassword.value =
                                !controller.hidePassword.value;
                          },
                          icon: Icon(
                            controller.hidePassword.value
                                ? Iconsax.eye
                                : Iconsax.eye_slash,
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
