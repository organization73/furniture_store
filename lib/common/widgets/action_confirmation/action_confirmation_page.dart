import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furniture_store/common/widgets/text_header.dart';
import 'package:furniture_store/utils/constants/image_strings.dart';
import 'package:furniture_store/utils/constants/sizes.dart';
import 'package:get/get.dart';

import 'package:lottie/lottie.dart';
// TODO Translate this page

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
      bottomNavigationBar: BottomAppBar(
        height: 68,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: ElevatedButton(onPressed: onPressed, child: Text('cont'.tr)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Lottie.asset(
              TImages.confirmation,
              width: 150,
            ),
            SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            BuildTopText(
              title: title,
              subTitle: '',
              alignment: CrossAxisAlignment.center,
            ),
            SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            Text(
              subTitle,
              style: Theme.of(context).textTheme.labelSmall,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 60.h,
            ),
          ]),
        ),
      ),
    );
  }
}
