import 'package:flutter/material.dart';
import 'package:decordash/common/widgets/input_fields/build_user_input_field.dart';
import 'package:decordash/common/widgets/buttons/cta_button.dart';
import 'package:decordash/common/widgets/headings/page_header.dart';
import 'package:decordash/features/authentication/controllers/sign_up/sign_up_controller.dart';
import 'package:decordash/utils/constants/sizes.dart';

import 'package:decordash/utils/validators/validation.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(),
      bottomNavigationBar: BottomAppBar(
        height: 73,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: BuildCTAButton(
          text: 'signUp'.tr,
          onPressed: () {
            controller.signup();
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: TSizes.pagePaddingSpace),
          child: Form(
            key: controller.formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  PageHeader(
                      title: 'signupTitle'.tr,
                      subTitle: 'loginSubTitle'.tr,
                      iconName: Iconsax.personalcard),
                  Row(
                    children: [
                      Expanded(
                        child: RoundedTextField(
                            'firstName'.tr,
                            controller.firstNameController,
                            prefixIcon: Iconsax.user_copy,
                            keyboardType: TextInputType.name,
                            TValidator.validateUserInput),
                      ),
                      const SizedBox(width: TSizes.sm),
                      Expanded(
                        child: RoundedTextField(
                            prefixIcon: Iconsax.user_copy,
                            'lastName'.tr,
                            controller.lastNameController,
                            keyboardType: TextInputType.name,
                            TValidator.validateUserInput),
                      ),
                    ],
                  ),
                  SizedBox(height: TSizes.spaceBtwInputFields),
                  RoundedTextField(
                      'username'.tr,
                      controller.userNameController,
                      prefixIcon: Iconsax.user_edit_copy,
                      keyboardType: TextInputType.name,
                      TValidator.validateUserInput),
                  SizedBox(height: TSizes.spaceBtwInputFields),
                  RoundedTextField(
                      'email'.tr,
                      prefixIcon: Iconsax.direct_copy,
                      keyboardType: TextInputType.emailAddress,
                      controller.emailController,
                      TValidator.validateEmail),
                  SizedBox(height: TSizes.spaceBtwInputFields),
                  RoundedTextField(
                      'phoneNo'.tr,
                      prefixIcon: Iconsax.call_copy,
                      keyboardType: TextInputType.phone,
                      controller.phoneNumController,
                      TValidator.validatePhoneNumber),
                  SizedBox(height: TSizes.spaceBtwInputFields),
                  GetX<SignUpController>(
                    builder: (controller) => Column(
                      children: [
                        RoundedTextField(
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
                                  size: TSizes.iconMd,
                                )),
                            controller.passwordController,
                            TValidator.validatePassword,
                            isPassword: controller.hidePassword.value),
                      ],
                    ),
                  ),
                  SizedBox(height: TSizes.spaceBtwInputFields),
                  Row(
                    children: [
                      SizedBox(
                        width: 25,
                        height: 35,
                        child: Obx(() => Checkbox(
                            value: controller.privacyPolicy.value,
                            onChanged: (value) {
                              controller.privacyPolicy.value =
                                  !controller.privacyPolicy.value;
                            })),
                      ),
                      SizedBox(
                        width: TSizes.spaceBtwItems,
                      ),
                      Text.rich(TextSpan(children: [
                        TextSpan(
                            text: '${'iAgreeTo'.tr} ',
                            style: Theme.of(context).textTheme.labelSmall),
                        TextSpan(
                            text: 'privacyPolicy'.tr,
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .apply(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    decoration: TextDecoration.underline,
                                    decorationColor:
                                        Theme.of(context).colorScheme.primary)),
                        TextSpan(
                            text: ' ${'and'.tr} ',
                            style: Theme.of(context).textTheme.labelSmall),
                        TextSpan(
                            text: 'termsOfUse'.tr,
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .apply(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    decoration: TextDecoration.underline,
                                    decorationColor:
                                        Theme.of(context).colorScheme.primary)),
                      ]))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
