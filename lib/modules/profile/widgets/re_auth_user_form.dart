import 'package:decordashapp/common/widgets/headings/page_header.dart';
import 'package:flutter/material.dart';
import 'package:decordashapp/common/widgets/input_fields/build_user_input_field.dart';
import 'package:decordashapp/common/widgets/buttons/cta_button.dart';
import 'package:decordashapp/modules/profile/controllers/user_controller.dart';
import 'package:decordashapp/utils/constants/sizes.dart';
import 'package:decordashapp/utils/validators/validation.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class ReAuthLoginForm extends StatelessWidget {
  const ReAuthLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    return Scaffold(
        appBar: AppBar(),
        bottomNavigationBar: BottomAppBar(
          child: BuildCTAButton(
              text: 'Delete',
              onPressed: () => controller.reAuthEmailAndPasswordUser()),
        ),
        body: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: TSizes.pagePaddingSpace),
          child: Form(
              key: controller.reAuthFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const PageHeader(
                      title: 'Email Verification',
                      subTitle: 'Please verify your email and password',
                      iconName: IconsaxPlusBroken.security_user),
                  RoundedTextField(
                      prefixIcon: IconsaxPlusLinear.direct_right,
                      'email'.tr,
                      focusNode: controller.verifyEmailFocus,
                      currentFocus: controller.verifyEmailFocus,
                      nextFocus: controller.verifyPasswordFocus,
                      keyboardType: TextInputType.emailAddress,
                      controller.verifyEmail,
                      TValidator.validateEmail),
                  const SizedBox(height: TSizes.spaceBtwInputFields),
                  Obx(() => RoundedTextField(
                      'password'.tr,
                      focusNode: controller.verifyPasswordFocus,
                      onFieldSubmitted: () =>
                          controller.reAuthEmailAndPasswordUser(),
                      prefixIcon: IconsaxPlusLinear.password_check,
                      suffixIcon: IconButton(
                          onPressed: () {
                            controller.hidePassword.value =
                                !controller.hidePassword.value;
                          },
                          icon: Icon(
                            controller.hidePassword.value
                                ? IconsaxPlusLinear.eye
                                : IconsaxPlusLinear.eye_slash,
                            size: TSizes.iconSm,
                          )),
                      controller.verifyPassword,
                      TValidator.validatePassword,
                      isPassword: controller.hidePassword.value)),
                  const SizedBox(height: TSizes.spaceBtwInputFields),
                ],
              )),
        ));
  }
}
