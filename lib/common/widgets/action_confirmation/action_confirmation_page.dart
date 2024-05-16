import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:decordash/common/widgets/headings/page_header.dart';
import 'package:decordash/utils/constants/image_strings.dart';
import 'package:decordash/utils/constants/sizes.dart';
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
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: ElevatedButton(onPressed: onPressed, child: Text('cont'.tr)),
      ),
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: TSizes.pagePaddingSpace),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Lottie.asset(
              TImages.confirmation,
              width: 150.w,
            ),
            SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            PageHeader(
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
