import 'package:decordashapp/utils/helpers/helper_functions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:decordashapp/common/widgets/input_fields/build_user_input_field.dart';
import 'package:decordashapp/common/widgets/buttons/cta_button.dart';
import 'package:decordashapp/common/widgets/headings/page_header.dart';
import 'package:decordashapp/modules/authentication/controllers/sign_up/sign_up_controller.dart';
import 'package:decordashapp/utils/constants/sizes.dart';
import 'package:decordashapp/utils/validators/validation.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());

    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: BottomAppBar(
        child: BuildCTAButton(
            text: 'signUp'.tr, onPressed: () => controller.signup()),
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
                      iconName: IconsaxPlusBroken.profile_2user),
                  Row(
                    children: [
                      Expanded(
                        child: RoundedTextField(
                            'firstName'.tr,
                            focusNode: controller.firstNameFocus,
                            currentFocus: controller.firstNameFocus,
                            nextFocus: controller.lastNameFocus,
                            controller.firstNameController,
                            prefixIcon: IconsaxPlusLinear.user,
                            keyboardType: TextInputType.name,
                            TValidator.validateUserInput),
                      ),
                      const SizedBox(width: TSizes.sm),
                      Expanded(
                        child: RoundedTextField(
                            prefixIcon: IconsaxPlusLinear.clipboard_text,
                            'lastName'.tr,
                            focusNode: controller.lastNameFocus,
                            currentFocus: controller.lastNameFocus,
                            nextFocus: controller.emailFocus,
                            controller.lastNameController,
                            keyboardType: TextInputType.name,
                            TValidator.validateUserInput),
                      ),
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwInputFields),
                  RoundedTextField(
                      'email'.tr,
                      focusNode: controller.emailFocus,
                      currentFocus: controller.emailFocus,
                      nextFocus: controller.phoneNumberFocus,
                      prefixIcon: IconsaxPlusLinear.sms,
                      keyboardType: TextInputType.emailAddress,
                      controller.emailController,
                      TValidator.validateEmail),
                  const SizedBox(height: TSizes.spaceBtwInputFields),
                  InternationalPhoneNumberInput(
                    onFieldSubmitted: (value) {
                      controller.phoneNumberFocus.unfocus();
                      FocusScope.of(context)
                          .requestFocus(controller.passwordFocus);
                    },
                    focusNode: controller.phoneNumberFocus,
                    onInputChanged: (PhoneNumber number) {},
                    onInputValidated: (bool value) {
                      if (value) {
                        controller.formKey.currentState!.save();
                      }
                    },
                    textStyle: const TextStyle(fontSize: TSizes.fontSizeSm),
                    inputDecoration: InputDecoration(
                      border: const OutlineInputBorder().copyWith(
                        borderRadius:
                            BorderRadius.circular(TSizes.inputFieldRadius),
                      ),
                      labelText: 'phoneNo'.tr,
                    ),
                    selectorConfig: const SelectorConfig(
                        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                        useBottomSheetSafeArea: true,
                        setSelectorButtonAsPrefixIcon: true,
                        leadingPadding: 15,
                        useEmoji: true),
                    initialValue: controller.number,
                    textFieldController: controller.phoneNumberController,
                    formatInput: false,
                    countries: const ["EG"],
                    keyboardType: const TextInputType.numberWithOptions(
                        signed: false, decimal: false),
                    inputBorder: const OutlineInputBorder(),
                    onSaved: (PhoneNumber number) {
                      controller.number = number;
                    },
                  ),
                  const SizedBox(height: TSizes.spaceBtwInputFields),
                  GetX<SignUpController>(
                    builder: (controller) => Column(
                      children: [
                        RoundedTextField(
                            'password'.tr,
                            focusNode: controller.passwordFocus,
                            onFieldSubmitted: () => controller.signup(),
                            prefixIcon: IconsaxPlusLinear.lock,
                            suffixIcon: IconButton(
                                onPressed: () {
                                  controller.hidePassword.value =
                                      !controller.hidePassword.value;
                                },
                                icon: Icon(
                                  controller.hidePassword.value
                                      ? IconsaxPlusLinear.eye
                                      : IconsaxPlusLinear.eye_slash,
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
                                ..onTap = () =>
                                    THelperFunctions.showTermsBottomSheet(
                                        context,
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
                                ..onTap = () =>
                                    THelperFunctions.showTermsBottomSheet(
                                        context,
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
}
