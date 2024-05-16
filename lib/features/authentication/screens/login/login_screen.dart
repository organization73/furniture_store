import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:decordash/common/widgets/buttons/cta_button.dart';
import 'package:decordash/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:decordash/features/authentication/controllers/log_in/log_in_controller.dart';
import 'package:decordash/features/authentication/screens/login/email_sign_in.dart';
import 'package:decordash/features/authentication/screens/sign_in_with_phone/phone_sign_in_screen.dart';
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
                height: 400.h,
                child: Padding(
                  padding: const EdgeInsets.all(TSizes.pagePaddingSpace),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('loginHeader'.tr,
                          style: Theme.of(context).textTheme.headlineLarge),
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
                      SizedBox(height: TSizes.spaceBtwItems / 4),
                      BuildCTAButton(
                        text: 'continueWithPhone'.tr,
                        onPressed: () => Get.to(
                          () => PhoneNumberScreen(),
                          duration: const Duration(milliseconds: 300),
                          transition: Transition.rightToLeft,
                        ),
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Divider(
                              indent: 60,
                              endIndent: 5,
                            ),
                          ),
                          Text('Or'),
                          Flexible(
                            child: Divider(
                              indent: 5,
                              endIndent: 60,
                            ),
                          )
                        ],
                      ),
                      IconButton.outlined(
                        onPressed: () => controller.googleSignIn(),
                        icon: SvgPicture.asset(TImages.google),
                        padding: const EdgeInsets.all(15),
                      ),
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
