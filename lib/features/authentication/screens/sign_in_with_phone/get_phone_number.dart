import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furniture_store/common/widgets/build_user_input_field.dart';
import 'package:furniture_store/common/widgets/cta_button.dart';
import 'package:furniture_store/common/widgets/text_header.dart';
import 'package:furniture_store/features/authentication/controllers/phone_sign_in/phone_sign_in_controller.dart';
import 'package:furniture_store/utils/constants/sizes.dart';

import 'package:furniture_store/utils/validators/validation.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class PhoneNumberScreen extends StatelessWidget {
  const PhoneNumberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PhoneSingInController());

    return Scaffold(
      bottomNavigationBar: BottomAppBar(
          height: 68,
          color: Theme.of(context).scaffoldBackgroundColor,
          child: BuildCTAButton(
            text: 'tContinue'.tr,
            onPressed: controller.phonedSignIn,
          )),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.pagePaddingSpace),
          child: Form(
            key: controller.phoneFormKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  BuildTopText(
                    title: 'continueWithPhoneTitle'.tr,
                    subTitle: 'continueWithPhoneSubTitle'.tr,
                    iconName: Iconsax.call5,
                  ),
                  SizedBox(height: 20.h),
                  RoundedTextField(
                      'phoneNo'.tr,
                      controller.phoneNumController,
                      prefixIcon: Iconsax.call,
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
