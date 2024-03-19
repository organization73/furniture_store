import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:decordash/common/widgets/buttons/cta_button.dart';
import 'package:decordash/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:decordash/features/authentication/controllers/log_in/log_in_controller.dart';
import 'package:decordash/features/authentication/screens/login/email_sign_in.dart';
import 'package:decordash/features/authentication/screens/sign_in_with_phone/get_phone_number.dart';
import 'package:decordash/features/authentication/screens/sign_up/signup.dart';
import 'package:decordash/utils/constants/image_strings.dart';
import 'package:decordash/utils/constants/sizes.dart';

import 'package:get/get.dart';

class LoginSignUpScreen extends StatelessWidget {
  const LoginSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          PrimaryHeaderContainer(
              child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
                SvgPicture.asset(
                  'assets/logos/logo.svg',
                  width: 200.r,
                ),
              ],
            ),
          )),
          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20.r),
                    )),
                height: 420.h,
                child: Padding(
                  padding: const EdgeInsets.all(TSizes.pagePaddingSpace),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('loginHeader'.tr,
                          style: Theme.of(context).textTheme.headlineMedium),
                      SizedBox(height: TSizes.spaceBtwSections),
                      Text(
                        'loginSubHeader'.tr,
                        style: Theme.of(context).textTheme.labelSmall,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: TSizes.spaceBtwSections / 2),
                      BuildCTAButton(
                        text: 'continueWithEmail'.tr,
                        onPressed: () => Get.to(
                          () => const EmailSignInScreen(),
                          duration: const Duration(milliseconds: 300),
                          transition: Transition.rightToLeft,
                        ),
                      ),
                      SizedBox(height: TSizes.spaceBtwItems / 2),
                      BuildCTAButton(
                        text: 'continueWithPhone'.tr,
                        onPressed: () => Get.to(
                          () => PhoneNumberScreen(),
                          duration: const Duration(milliseconds: 300),
                          transition: Transition.rightToLeft,
                        ),
                      ),
                      SizedBox(height: TSizes.spaceBtwItems / 2),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          onPressed: () => controller.googleSignIn(),
                          style: FilledButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                vertical: TSizes.buttonHeight - 3,
                                horizontal: 10),
                            backgroundColor:
                                Theme.of(context).colorScheme.surfaceVariant,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(TSizes.buttonRadius)),
                          ),
                          icon: SvgPicture.asset(TImages.google),
                          label: Text(
                            'continueWithGoogle'.tr,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      ),
                      SizedBox(height: TSizes.spaceBtwItems / 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'newToApp'.tr,
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                          TextButton(
                            onPressed: () {
                              Get.to(
                                () => const SignUpScreen(),
                                duration: const Duration(milliseconds: 300),
                                transition: Transition.downToUp,
                              );
                            },
                            child: Text(
                              'createAccount'.tr,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
