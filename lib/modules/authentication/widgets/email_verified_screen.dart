import 'package:decordashapp/common/widgets/headings/page_header.dart';
import 'package:decordashapp/utils/constants/image_strings.dart';
import 'package:decordashapp/utils/constants/sizes.dart';
import 'package:decordashapp/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmailVerifiedScreen extends StatelessWidget {
  const EmailVerifiedScreen({
    super.key,
    required this.title,
    required this.subTitle,
  });

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Lottie.asset(
        ImageStrings.confirmation,
        width: TDeviceUtils.getScreenWidth(context) * 0.35,
      ),
      const SizedBox(
        height: TSizes.spaceBtwItems,
      ),
      PageHeader(
        title: title,
        subTitle: '',
        alignment: CrossAxisAlignment.center,
        align: TextAlign.center,
      ),
      const SizedBox(
        height: TSizes.spaceBtwItems,
      ),
      Text(
        subTitle,
        style: Theme.of(context).textTheme.bodySmall,
        textAlign: TextAlign.center,
      ),
    ]);
  }
}
