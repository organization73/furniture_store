import 'package:decordashapp/common/widgets/buttons/cta_button.dart';
import 'package:decordashapp/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:decordashapp/common/widgets/headings/page_header.dart';
import 'package:decordashapp/utils/constants/image_strings.dart';
import 'package:decordashapp/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class ActionConfirmPage extends StatelessWidget {
  final String title;
  final String subTitle;
  final VoidCallback onPressed;

  const ActionConfirmPage({
    super.key,
    required this.title,
    required this.subTitle,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: BuildCTAButton(onPressed: onPressed, text: 'cont'.tr),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: TSizes.pagePaddingSpace),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Lottie.asset(
                TImages.confirmation,
                width: TDeviceUtils.getScreenHeight() * 0.2,
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
            ]),
          ),
        ),
      ),
    );
  }
}
