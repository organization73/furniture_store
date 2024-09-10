import 'package:decordashapp/utils/device/device_utility.dart';
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
                            prefixIcon: Iconsax.user_copy,
                            'lastName'.tr,
                            controller.lastNameController,
                            keyboardType: TextInputType.name,
                            TValidator.validateUserInput),
                      ),
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwInputFields),
                  RoundedTextField(
                      'username'.tr,
                      controller.userNameController,
                      prefixIcon: Iconsax.user_edit_copy,
                      keyboardType: TextInputType.name,
                      TValidator.validateUserInput),
                  const SizedBox(height: TSizes.spaceBtwInputFields),
                  RoundedTextField(
                      'email'.tr,
                      prefixIcon: Iconsax.direct_copy,
                      keyboardType: TextInputType.emailAddress,
                      controller.emailController,
                      TValidator.validateEmail),
                  const SizedBox(height: TSizes.spaceBtwInputFields),
                  InternationalPhoneNumberInput(
                    onInputChanged: (PhoneNumber number) {
                      controller.phoneNumController.value =
                          number.phoneNumber as TextEditingValue;
                    },
                    inputDecoration: InputDecoration(
                      border: const OutlineInputBorder().copyWith(
                        borderRadius:
                            BorderRadius.circular(TSizes.inputFieldRadius),
                      ),
                      labelText: 'phoneNo'.tr,
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                      signed: true,
                      decimal: false,
                    ),
                    selectorConfig: const SelectorConfig(
                        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                        setSelectorButtonAsPrefixIcon: true,
                        leadingPadding: 15,
                        useEmoji: true),
                    initialValue: PhoneNumber(
                      isoCode: 'EG',
                    ),
                    formatInput: false,
                    countries: const ["EG"],
                  ),
                  const SizedBox(height: TSizes.spaceBtwInputFields),
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
                  const SizedBox(height: TSizes.spaceBtwInputFields),
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
      builder: (BuildContext context) {
        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
              child: SizedBox(
                height: TDeviceUtils.getScreenHeight() * 0.75,
                child: FutureBuilder(
                  future: rootBundle.loadString(filePath),
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.hasData) {
                      return MarkdownWidget(
                        config: MarkdownConfig(configs: [
                          const PConfig(textStyle: TextStyle(fontSize: 15)),
                          H1Config(
                              style:
                                  Theme.of(context).textTheme.headlineLarge!),
                          H2Config(
                              style:
                                  Theme.of(context).textTheme.headlineMedium!),
                          H3Config(
                              style:
                                  Theme.of(context).textTheme.headlineSmall!),
                          H4Config(
                              style: Theme.of(context).textTheme.labelMedium!),
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
              ),
            ),
            Positioned(
              top: 0.0,
              right: 0.0,
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Get.back(),
              ),
            ),
          ],
        );
      },
    );
  }
}
