import 'package:decordashapp/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:decordashapp/common/widgets/buttons/cta_button.dart';
import 'package:decordashapp/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:decordashapp/modules/authentication/controllers/log_in/log_in_controller.dart';
import 'package:decordashapp/modules/authentication/screens/signin/signin_screen.dart';
import 'package:decordashapp/modules/authentication/screens/phone_login/phone_signin_screen.dart';
import 'package:decordashapp/modules/authentication/screens/signup/signup_screen.dart';
import 'package:decordashapp/utils/constants/image_strings.dart';
import 'package:decordashapp/utils/constants/sizes.dart';
import 'package:get/get.dart';

class UserLoginScreen extends StatelessWidget {
  const UserLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return Scaffold(
      body: Stack(
        children: [
          PrimaryHeaderContainer(
              child: SvgPicture.asset(ImageStrings.logo, fit: BoxFit.cover)),
          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    )),
                height: TDeviceUtils.getScreenOrientation(context) ==
                        Orientation.portrait
                    ? TDeviceUtils.getScreenHeight(context) * 0.57
                    : TDeviceUtils.getScreenHeight(context),
                child: Padding(
                  padding: const EdgeInsets.all(TSizes.pagePaddingSpace),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('loginHeader'.tr,
                          style: Theme.of(context).textTheme.headlineSmall),
                      Text(
                        'loginSubHeader'.tr,
                        style: Theme.of(context).textTheme.labelMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: TSizes.spaceBtwSections / 2),
                      BuildCTAButton(
                        text: 'continueWithEmail'.tr,
                        onPressed: () => Get.to(
                          () => const SigninScreen(),
                          duration: const Duration(milliseconds: 300),
                          transition: Transition.rightToLeft,
                        ),
                      ),
                      BuildCTAButton(
                        text: 'continueWithPhone'.tr,
                        onPressed: () => Get.to(
                          () => const PhoneSigninScreen(),
                          duration: const Duration(milliseconds: 300),
                          transition: Transition.rightToLeft,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Flexible(
                            child: Divider(
                              indent: 60,
                              endIndent: 5,
                            ),
                          ),
                          Text('or'.tr),
                          const Flexible(
                            child: Divider(
                              indent: 5,
                              endIndent: 60,
                            ),
                          )
                        ],
                      ),
                      IconButton.outlined(
                        onPressed: () => controller.googleSignIn(),
                        icon: SvgPicture.asset(ImageStrings.google),
                        padding: const EdgeInsets.all(15),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'newToApp'.tr,
                            style: Theme.of(context).textTheme.labelMedium,
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
