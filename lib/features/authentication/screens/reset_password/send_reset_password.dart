import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furniture_store/common/widgets/build_user_input_field.dart';
import 'package:furniture_store/common/widgets/cta_button.dart';
import 'package:furniture_store/common/widgets/text_header.dart';
import 'package:furniture_store/features/authentication/controllers/forget_password/forget_password_controller.dart';
import 'package:furniture_store/utils/constants/sizes.dart';

import 'package:furniture_store/utils/validators/validation.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SentEmailPasswordReset extends StatelessWidget {
  const SentEmailPasswordReset({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: BottomAppBar(
          height: 68,
          color: Theme.of(context).scaffoldBackgroundColor,
          child: BuildCTAButton(
            text: 'tContinue'.tr,
            onPressed: () => controller.sendPasswordResetEmail(),
          )),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: TSizes.pagePaddingSpace),
          child: Form(
            key: controller.forgotPassFormKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  BuildTopText(
                    title: 'forgetPasswordTitle'.tr,
                    subTitle: 'forgetPasswordSubTitle'.tr,
                  ),
                  SizedBox(height: 20.h),
                  RoundedTextField(
                      'email'.tr,
                      prefixIcon: Iconsax.direct_right,
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
