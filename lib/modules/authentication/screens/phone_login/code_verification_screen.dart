import 'package:decordashapp/modules/authentication/controllers/phone_sign_in/otp_controller.dart';
import 'package:flutter/material.dart';
import 'package:decordashapp/common/widgets/buttons/cta_button.dart';
import 'package:decordashapp/utils/constants/sizes.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

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
                  IconsaxPlusBroken.lock_circle,
                  size: TSizes.iconLg * 3,
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                ),
                const SizedBox(height: TSizes.spaceBtwSections * 2),
                Text(
                  'enterCode'.tr,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields * 2),
                Text(
                  'codeDesc'.tr,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                Text(
                  phoneNumber,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: TSizes.spaceBtwSections * 3),
                OtpTextField(
                  numberOfFields: 6,
                  showFieldAsBox: true,
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(10),
                  disabledBorderColor:
                      Theme.of(context).colorScheme.surfaceContainerLow,
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
