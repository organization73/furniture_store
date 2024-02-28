import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furniture_store/common/widgets/cta_button.dart';
import 'package:furniture_store/data/repositories/authentication/api_services.dart';
import 'package:furniture_store/features/authentication/controllers/log_in/log_in_controller.dart';
import 'package:furniture_store/features/authentication/screens/login/email_sign_in.dart';
import 'package:furniture_store/features/authentication/screens/sign_in_with_phone/get_phone_number.dart';
import 'package:furniture_store/features/authentication/screens/sign_up/signup.dart';
import 'package:furniture_store/utils/constants/image_strings.dart';
import 'package:furniture_store/utils/constants/sizes.dart';

import 'package:get/get.dart';

class LoginSignUpScreen extends StatelessWidget {
  const LoginSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    Get.put(HttpService());

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          SizedBox(
            width: 1.sw,
            child: Image.asset(
              TImages.appBackgroung,
              fit: BoxFit.fitWidth,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20.r),
                  )),
              height: 415.h,
              child: Padding(
                padding: const EdgeInsets.all(TSizes.pagePaddingSpace),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('loginHeader'.tr,
                        style: Theme.of(context).textTheme.headlineMedium),
                    SizedBox(height: 5.0.h),
                    Text(
                      'loginSubHeader'.tr,
                      style: Theme.of(context).textTheme.labelSmall,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 5.0.h),
                    BuildCTAButton(
                      text: 'continueWithEmail'.tr,
                      onPressed: () => Get.to(
                        () => const EmailSignInScreen(),
                        duration: const Duration(milliseconds: 300),
                        transition: Transition.rightToLeft,
                      ),
                    ),
                    SizedBox(height: 8.0.h),
                    BuildCTAButton(
                      text: 'continueWithPhone'.tr,
                      onPressed: () => Get.to(
                        () => const PhoneNumberScreen(),
                        duration: const Duration(milliseconds: 300),
                        transition: Transition.rightToLeft,
                      ),
                    ),
                    SizedBox(height: 8.0.h),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: () => controller.googleSignIn(),
                        style: FilledButton.styleFrom(
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
                    SizedBox(height: 8.0.h),
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
                                    color:
                                        Theme.of(context).colorScheme.primary),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
