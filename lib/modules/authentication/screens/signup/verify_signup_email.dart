import 'package:decordashapp/common/widgets/buttons/cta_button.dart';
import 'package:decordashapp/modules/authentication/widgets/check_email_verify_screen.dart';
import 'package:decordashapp/modules/authentication/widgets/email_verified_screen.dart';
import 'package:flutter/material.dart';
import 'package:decordashapp/data/repositories/authentication/authentication_repo.dart';
import 'package:decordashapp/modules/authentication/controllers/sign_up/verify_email_controller.dart';
import 'package:decordashapp/utils/constants/sizes.dart';
import 'package:get/get.dart';

class VerifySignUpEmail extends StatelessWidget {
  final String? email;
  const VerifySignUpEmail({super.key, this.email});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyEmailController());
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: BuildCTAButton(
          onPressed: () => controller.checkEmailVerificationStatus(),
          text: 'cont'.tr,
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => AuthenticatorRepo.instance.logOut(),
              icon: const Icon(Icons.clear))
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: TSizes.pagePaddingSpace),
            child: Obx(() {
              return (controller.isEmailVerified.value)
                  ? EmailVerifiedScreen(
                      title: 'yourAccountCreatedTitle'.tr,
                      subTitle: 'yourAccountCreatedSubTitle'.tr,
                    )
                  : CheckVerifyScreen(email: email, controller: controller);
            }),
          ),
        ),
      ),
    );
  }
}
