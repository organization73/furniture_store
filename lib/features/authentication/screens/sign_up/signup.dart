import 'package:decordashapp/features/authentication/widgets/phone_number_input.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:decordashapp/common/widgets/input_fields/build_user_input_field.dart';
import 'package:decordashapp/common/widgets/buttons/cta_button.dart';
import 'package:decordashapp/common/widgets/headings/page_header.dart';
import 'package:decordashapp/features/authentication/controllers/sign_up/sign_up_controller.dart';
import 'package:decordashapp/utils/constants/sizes.dart';
import 'package:decordashapp/utils/validators/validation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:markdown_widget/markdown_widget.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(),
      bottomNavigationBar: BottomAppBar(
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
                            prefixIcon: Iconsax.clipboard_text_copy,
                            'lastName'.tr,
                            controller.lastNameController,
                            keyboardType: TextInputType.name,
                            TValidator.validateUserInput),
                      ),
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwInputFields),
                  RoundedTextField(
                      'email'.tr,
                      prefixIcon: Iconsax.sms_copy,
                      keyboardType: TextInputType.emailAddress,
                      controller.emailController,
                      TValidator.validateEmail),
                  const SizedBox(height: TSizes.spaceBtwInputFields),
                  PhoneNumberInput(
                    onChange: (PhoneNumber number) {
                      controller.phoneNumController.value = number.phoneNumber!;
                    },
                  ),
                  const SizedBox(height: TSizes.spaceBtwInputFields),
                  GetX<SignUpController>(
                    builder: (controller) => Column(
                      children: [
                        RoundedTextField(
                            'password'.tr,
                            prefixIcon: Iconsax.lock_copy,
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
                  const SizedBox(height: TSizes.spaceBtwInputFields),
                  Row(
                    children: [
                      SizedBox(
                        width: 25,
                        child: Obx(() => Checkbox(
                            value: controller.privacyPolicy.value,
                            onChanged: (value) {
                              controller.privacyPolicy.value =
                                  !controller.privacyPolicy.value;
                            })),
                      ),
                      const SizedBox(
                        width: TSizes.spaceBtwItems,
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '${'iAgreeTo'.tr} ',
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            TextSpan(
                              text: 'privacyPolicy'.tr,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    decoration: TextDecoration.underline,
                                    decorationColor:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => _showBottomSheet(context,
                                    'assets/markdown/privacy_policy.md'),
                            ),
                            TextSpan(
                              text: ' ${'and'.tr} ',
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            TextSpan(
                              text: 'termsOfUse'.tr,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    decoration: TextDecoration.underline,
                                    decorationColor:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => _showBottomSheet(context,
                                    'assets/markdown/terms_and_conditions.md'),
                            ),
                          ],
                        ),
                      )
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

  void _showBottomSheet(BuildContext context, String filePath) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: FutureBuilder(
            future: rootBundle.loadString(filePath),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.hasData) {
                return MarkdownWidget(
                  config: MarkdownConfig(configs: [
                    const PConfig(textStyle: TextStyle(fontSize: 13)),
                    H1Config(
                        style: Theme.of(context).textTheme.headlineMedium!),
                    H2Config(style: Theme.of(context).textTheme.headlineSmall!),
                    H3Config(style: Theme.of(context).textTheme.titleMedium!),
                    H4Config(style: Theme.of(context).textTheme.titleSmall!),
                    const TableConfig(
                      columnWidths: {0: FractionColumnWidth(0.25)},
                    ),
                    ListConfig(
                      marker: (isOrdered, depth, index) => const Padding(
                        padding: EdgeInsets.only(top: 6),
                        child: Icon(Icons.circle, size: 6),
                      ),
                    ),
                  ]),
                  data: snapshot.data!,
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        );
      },
    );
  }
}
