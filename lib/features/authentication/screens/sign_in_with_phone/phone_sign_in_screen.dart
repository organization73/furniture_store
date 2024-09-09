import 'package:decordashapp/common/widgets/input_fields/build_user_input_field.dart';
import 'package:decordashapp/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:decordashapp/common/widgets/buttons/cta_button.dart';
import 'package:decordashapp/common/widgets/headings/page_header.dart';
import 'package:decordashapp/features/authentication/controllers/phone_sign_in/phone_sign_in_controller.dart';
import 'package:decordashapp/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class PhoneNumberScreen extends StatelessWidget {
  PhoneNumberScreen({super.key});

  final PhoneNumber number = PhoneNumber(
    isoCode: 'EG',
  );

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PhoneSingInController());

    return Scaffold(
      bottomNavigationBar: BottomAppBar(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: BuildCTAButton(
              text: 'tContinue'.tr,
              onPressed: () {
                controller.loginWithPhone();
              })),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: TSizes.pagePaddingSpace),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PageHeader(
                  title: 'continueWithPhoneTitle'.tr,
                  subTitle: 'continueWithPhoneSubTitle'.tr,
                  iconName: Iconsax.call,
                ),
                Form(
                  key: controller.formKey,
                  child: Column(
                    children: <Widget>[
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
                      InternationalPhoneNumberInput(
                        onInputChanged: (PhoneNumber number) {
                          controller.phoneNumber.value = number.phoneNumber!;
                        },
                        inputBorder: const OutlineInputBorder().copyWith(
                          borderRadius:
                              BorderRadius.circular(TSizes.inputFieldRadius),
                        ),
                        selectorConfig: const SelectorConfig(
                          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                          setSelectorButtonAsPrefixIcon: true,
                          leadingPadding: 15,
                        ),
                        initialValue: number,
                        formatInput: true,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
