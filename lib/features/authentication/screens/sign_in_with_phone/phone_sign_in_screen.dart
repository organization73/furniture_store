import 'package:decordash/common/widgets/input_fields/build_user_input_field.dart';
import 'package:decordash/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:decordash/common/widgets/buttons/cta_button.dart';
import 'package:decordash/common/widgets/headings/page_header.dart';
import 'package:decordash/features/authentication/controllers/phone_sign_in/phone_sign_in_controller.dart';
import 'package:decordash/utils/constants/sizes.dart';

import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class PhoneNumberScreen extends StatelessWidget {
  PhoneNumberScreen({super.key});

  final String initialCountry = 'EG';
  final PhoneNumber number = PhoneNumber(
    isoCode: 'EG',
  );

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PhoneSingInController());

    return Scaffold(
      bottomNavigationBar: BottomAppBar(
          height: 73,
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
                      SizedBox(height: TSizes.spaceBtwInputFields),
                      RoundedTextField(
                          'username'.tr,
                          controller.userNameController,
                          prefixIcon: Iconsax.user_edit_copy,
                          keyboardType: TextInputType.name,
                          TValidator.validateUserInput),
                      SizedBox(height: TSizes.spaceBtwInputFields),
                      InternationalPhoneNumberInput(
                        onInputChanged: null,
                        selectorConfig: const SelectorConfig(
                          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                          useBottomSheetSafeArea: true,
                          setSelectorButtonAsPrefixIcon: true,
                          leadingPadding: 15,
                          trailingSpace: false,
                        ),
                        ignoreBlank: false,
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        initialValue: number,
                        // textFieldController: controller.phoneNumController,
                        formatInput: true,
                        keyboardType: TextInputType.phone,
                        onSaved: (PhoneNumber number) {
                          controller.phoneNumController.text =
                              number.phoneNumber!;
                        },
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
