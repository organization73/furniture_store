import 'package:decordashapp/modules/authentication/screens/reset_password/forget_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:decordashapp/common/widgets/input_fields/build_user_input_field.dart';
import 'package:decordashapp/common/widgets/buttons/cta_button.dart';
import 'package:decordashapp/common/widgets/headings/page_header.dart';
import 'package:decordashapp/modules/authentication/controllers/log_in/log_in_controller.dart';
import 'package:decordashapp/utils/constants/sizes.dart';
import 'package:decordashapp/utils/validators/validation.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = LoginController.instance;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        forceMaterialTransparency: true,
      ),
      bottomNavigationBar: BottomAppBar(
        child: BuildCTAButton(
            text: 'signIn'.tr,
            onPressed: () => controller.emailAndPasswordSignIn()),
      ),
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: TSizes.pagePaddingSpace),
          child: Form(
            key: controller.loginFormKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PageHeader(
                      title: 'loginTitle'.tr,
                      subTitle: 'loginSubTitle'.tr,
                      iconName: IconsaxPlusBroken.profile_tick),
                  RoundedTextField(
                      prefixIcon: IconsaxPlusLinear.sms,
                      'email'.tr,
                      focusNode: controller.emailFocus,
                      currentFocus: controller.emailFocus,
                      nextFocus: controller.passwordFocus,
                      keyboardType: TextInputType.emailAddress,
                      controller.emailController,
                      TValidator.validateEmail),
                  const SizedBox(height: TSizes.spaceBtwInputFields),
                  Obx(() => RoundedTextField(
                      'password'.tr,
                      focusNode: controller.passwordFocus,
                      onFieldSubmitted: () =>
                          controller.emailAndPasswordSignIn(),
                      prefixIcon: IconsaxPlusLinear.lock,
                      suffixIcon: IconButton(
                          onPressed: () {
                            controller.hidePassword.value =
                                !controller.hidePassword.value;
                          },
                          icon: Icon(
                            controller.hidePassword.value
                                ? IconsaxPlusLinear.eye
                                : IconsaxPlusLinear.eye_slash,
                            size: TSizes.iconMd,
                          )),
                      controller.passwordController,
                      TValidator.validatePassword,
                      isPassword: controller.hidePassword.value)),
                  const SizedBox(height: TSizes.spaceBtwInputFields),
                  TextButton(
                    onPressed: () => Get.to(
                      () => const ForgetPasswordScreen(),
                      transition: Transition.downToUp,
                    ),
                    child: Text('forgetPassword'.tr,
                        style: Theme.of(context).textTheme.labelMedium),
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
