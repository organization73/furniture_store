import 'package:decordashapp/common/widgets/input_fields/custom_text_form_field.dart';
import 'package:decordashapp/modules/home/screens/search/search_screen.dart';
import 'package:decordashapp/utils/constants/sizes.dart';
import 'package:decordashapp/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class FadeAppBar extends StatelessWidget {
  final double scrollOffset;
  const FadeAppBar({super.key, required this.scrollOffset});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: TDeviceUtils.getStatusBarHeight(context) + 65,
      color: Theme.of(context)
          .scaffoldBackgroundColor
          .withOpacity((scrollOffset / 350).clamp(0, 1).toDouble()),
      child: SafeArea(
        child: Center(
          child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: TSizes.pagePaddingSpace),
              child: CustomTextFormField(
                hint: 'homeSearchBarHint'.tr,
                prefixIcon: IconsaxPlusLinear.search_normal,
                readOnly: true,
                filled: true,
                onTap: () => Get.to(
                  () => const SearchScreen(),
                  transition: Transition.downToUp,
                ),
              )),
        ),
      ),
    );
  }
}
