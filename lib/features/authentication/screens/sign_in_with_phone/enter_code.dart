import 'package:decordash/features/authentication/controllers/phone_sign_in/otp_controller.dart';
import 'package:flutter/material.dart';

import 'package:decordash/common/widgets/buttons/cta_button.dart';
import 'package:decordash/utils/constants/sizes.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class CodeVerificationScreen extends StatelessWidget {
  final String phoneNumber;
  const CodeVerificationScreen({
    super.key,
    required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OTPController());
    String otp = '';
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      bottomNavigationBar: BottomAppBar(
        height: 70.h,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: BuildCTAButton(
          text: 'verify'.tr,
          onPressed: () => controller.verifyOTP(otp),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: TSizes.pagePaddingSpace),
          child: PopScope(
            canPop: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Iconsax.verify,
                  size: 45.r,
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                ),
                SizedBox(height: TSizes.spaceBtwSections),
                Text(
                  'enterCode'.tr,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SizedBox(height: TSizes.spaceBtwInputFields),
                Text(
                  'codeDesc'.tr,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                SizedBox(height: TSizes.spaceBtwInputFields),
                Text(
                  phoneNumber,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                SizedBox(height: TSizes.spaceBtwSections),
                OtpTextField(
                  numberOfFields: 6,
                  borderColor: Theme.of(context).primaryColor,
                  showFieldAsBox: true,
                  onCodeChanged: (String code) {
                    //handle validation or checks here
                  },
                  onSubmit: (String verificationCode) {
                    otp = verificationCode;
                    controller.verifyOTP(otp);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
