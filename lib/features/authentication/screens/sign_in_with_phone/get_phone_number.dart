import 'package:flutter/material.dart';
import 'package:decordash/common/widgets/input_fields/build_user_input_field.dart';
import 'package:decordash/common/widgets/buttons/cta_button.dart';
import 'package:decordash/common/widgets/headings/page_header.dart';
import 'package:decordash/features/authentication/controllers/phone_sign_in/phone_sign_in_controller.dart';
import 'package:decordash/utils/constants/sizes.dart';

import 'package:decordash/utils/validators/validation.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class PhoneNumberScreen extends StatelessWidget {
  const PhoneNumberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PhoneSingInController());

    return Scaffold(
      bottomNavigationBar: BottomAppBar(
          height: 73,
          color: Theme.of(context).scaffoldBackgroundColor,
          child: BuildCTAButton(
            text: 'tContinue'.tr,
            onPressed: controller.phonedSignIn,
          )),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: TSizes.pagePaddingSpace),
          child: Form(
            key: controller.phoneFormKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  PageHeader(
                    title: 'continueWithPhoneTitle'.tr,
                    subTitle: 'continueWithPhoneSubTitle'.tr,
                    iconName: Iconsax.call,
                  ),
                  RoundedTextField(
                      'phoneNo'.tr,
                      controller.phoneNumController,
                      prefixIcon: Iconsax.call_copy,
                      TValidator.validatePhoneNumber,
                      keyboardType: TextInputType.phone),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
