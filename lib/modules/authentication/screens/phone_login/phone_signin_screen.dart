import 'package:flutter/material.dart';
import 'package:decordashapp/common/widgets/buttons/cta_button.dart';
import 'package:decordashapp/common/widgets/headings/page_header.dart';
import 'package:decordashapp/modules/authentication/controllers/phone_sign_in/phone_sign_in_controller.dart';
import 'package:decordashapp/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class PhoneSigninScreen extends StatelessWidget {
  const PhoneSigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PhoneSingInController());

    return Scaffold(
      bottomNavigationBar: BottomAppBar(
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
                  iconName: IconsaxPlusBroken.call,
                ),
                Form(
                  key: controller.formKey,
                  child: Column(
                    children: <Widget>[
                      InternationalPhoneNumberInput(
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
