import 'package:decordashapp/common/widgets/headings/page_header.dart';
import 'package:decordashapp/modules/authentication/controllers/sign_up/verify_email_controller.dart';
import 'package:decordashapp/utils/constants/image_strings.dart';
import 'package:decordashapp/utils/constants/sizes.dart';
import 'package:decordashapp/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class CheckVerifyScreen extends StatelessWidget {
  const CheckVerifyScreen({
    super.key,
    required this.email,
    required this.controller,
  });

  final String? email;
  final VerifyEmailController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(
            ImageStrings.emailDelivery,
            width: TDeviceUtils.getScreenWidth(context) * 0.35,
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
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          TextButton(
              onPressed: () => controller.sendEmailVerification(),
              child: Text('resendEmail'.tr))
        ]);
  }
}
