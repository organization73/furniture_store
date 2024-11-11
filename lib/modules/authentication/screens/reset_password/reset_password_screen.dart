import 'package:decordashapp/utils/constants/image_strings.dart';
import 'package:decordashapp/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:decordashapp/common/widgets/buttons/cta_button.dart';
import 'package:decordashapp/common/widgets/headings/page_header.dart';
import 'package:decordashapp/modules/authentication/controllers/forget_password/forget_password_controller.dart';
import 'package:decordashapp/modules/authentication/screens/user_login/user_login_screen.dart';
import 'package:decordashapp/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class ResetPasswordScreen extends StatelessWidget {
  final String email;
  const ResetPasswordScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
          child: BuildCTAButton(
              text: 'tContinue'.tr,
              onPressed: () => Get.offAll(
                    () => const UserLoginScreen(),
                    transition: Transition.downToUp,
                  ))),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.clear))
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: TSizes.pagePaddingSpace),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Lottie.asset(
                    ImageStrings.resetPassword,
                    width: TDeviceUtils.getScreenWidth(context) * 0.35,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  PageHeader(
                    title: 'passResetSent'.tr,
                    subTitle: email,
                    alignment: CrossAxisAlignment.center,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  Text(
                    'passResetSub'.tr,
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  TextButton(
                      onPressed: () => ForgetPasswordController.instance
                          .resendPasswordResetEmail(email),
                      child: Text(
                        'resendMail'.tr,
                        style: Theme.of(context).textTheme.labelMedium,
                      ))
                ]),
          ),
        ),
      ),
    );
  }
}
