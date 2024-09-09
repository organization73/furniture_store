import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:decordashapp/common/widgets/headings/page_header.dart';
import 'package:decordashapp/data/repositories/authentication/authentication_repo.dart';
import 'package:decordashapp/features/authentication/controllers/sign_up/verify_email_controller.dart';
import 'package:decordashapp/utils/constants/image_strings.dart';
import 'package:decordashapp/utils/constants/sizes.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class VerifySignUpEmail extends StatelessWidget {
  final String? email;
  const VerifySignUpEmail({super.key, this.email});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyEmailController());
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: ElevatedButton(
            onPressed: () => controller.checkEmailVerificationStatus(),
            child: Text('cont'.tr)),
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
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Lottie.asset(
                    TImages.emailDelivery,
                    width: 150.r,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  PageHeader(
                    title: 'confirmEmail'.tr,
                    subTitle: email ?? '',
                    alignment: CrossAxisAlignment.center,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  Text(
                    'confirmEmailSubTitle'.tr,
                    style: Theme.of(context).textTheme.labelSmall,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 60.h,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  TextButton(
                      onPressed: () => controller.sendEmailVerification(),
                      child: Text('resendEmail'.tr))
                ]),
          ),
        ),
      ),
    );
  }
}
