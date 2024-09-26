import 'package:flutter/material.dart';
import 'package:decordashapp/common/widgets/input_fields/build_user_input_field.dart';
import 'package:decordashapp/common/widgets/buttons/cta_button.dart';
import 'package:decordashapp/common/widgets/headings/page_header.dart';
import 'package:decordashapp/modules/authentication/controllers/forget_password/forget_password_controller.dart';
import 'package:decordashapp/utils/constants/sizes.dart';
import 'package:decordashapp/utils/validators/validation.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class SentEmailPasswordReset extends StatelessWidget {
  const SentEmailPasswordReset({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
      ),
      bottomNavigationBar: BottomAppBar(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: BuildCTAButton(
            text: 'tContinue'.tr,
            onPressed: () => controller.sendPasswordResetEmail(),
          )),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: TSizes.pagePaddingSpace),
          child: Form(
            key: controller.forgotPassFormKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  PageHeader(
                    title: 'forgetPasswordTitle'.tr,
                    subTitle: 'forgetPasswordSubTitle'.tr,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  RoundedTextField(
                      'email'.tr,
                      prefixIcon: Iconsax.direct_right_copy,
                      keyboardType: TextInputType.emailAddress,
                      controller.emailController,
                      TValidator.validateEmail),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
