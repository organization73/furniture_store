import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furniture_store/common/widgets/build_user_input_field.dart';
import 'package:furniture_store/common/widgets/cta_button.dart';
import 'package:furniture_store/common/widgets/text_header.dart';
import 'package:furniture_store/features/authentication/controllers/log_in/log_in_controller.dart';
import 'package:furniture_store/features/authentication/screens/reset_password/send_reset_password.dart';
import 'package:furniture_store/utils/constants/sizes.dart';

import 'package:furniture_store/utils/validators/validation.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class EmailSignInScreen extends StatelessWidget {
  const EmailSignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = LoginController.instance;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(),
      bottomNavigationBar: BottomAppBar(
        height: 68,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: BuildCTAButton(
            text: 'signIn'.tr,
            onPressed: () => controller.emailAndPasswordSignIn()),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.pagePaddingSpace),
          child: Form(
            key: controller.loginFormKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  BuildTopText(
                      title: 'loginTitle'.tr,
                      subTitle: 'loginSubTitle'.tr,
                      iconName: 'email'),
                  SizedBox(height: 20.h),
                  RoundedTextField(
                      prefixIcon: Iconsax.direct_right,
                      'email'.tr,
                      keyboardType: TextInputType.emailAddress,
                      controller.emailController,
                      TValidator.validateEmail),
                  SizedBox(height: TSizes.spaceBtwInputFields),
                  Obx(() => RoundedTextField(
                      'password'.tr,
                      prefixIcon: Iconsax.password_check,
                      suffixIcon: IconButton(
                          onPressed: () {
                            controller.hidePassword.value =
                                !controller.hidePassword.value;
                          },
                          icon: Icon(
                            controller.hidePassword.value
                                ? Iconsax.eye
                                : Iconsax.eye_slash,
                            size: TSizes.iconSm,
                          )),
                      controller.passwordController,
                      TValidator.validatePassword,
                      isPassword: controller.hidePassword.value)),
                  SizedBox(height: TSizes.spaceBtwInputFields),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 30,
                            height: 40,
                            child: Obx(() => Checkbox(
                                value: controller.rememberMe.value,
                                onChanged: (value) {
                                  controller.rememberMe.value =
                                      !controller.rememberMe.value;
                                })),
                          ),
                          SizedBox(
                            width: TSizes.spaceBtwItems,
                          ),
                          Text(
                            'rememberMe'.tr,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () => Get.to(
                          () => const SentEmailPasswordReset(),
                          duration: const Duration(milliseconds: 300),
                          transition: Transition.downToUp,
                        ),
                        child: Text('forgetPassword'.tr,
                            style: Theme.of(context).textTheme.labelSmall),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
