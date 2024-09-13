import 'package:decordashapp/common/widgets/input_fields/custom_text_form_field.dart';
import 'package:decordashapp/features/home/screens/search/search_screen.dart';
import 'package:decordashapp/utils/constants/sizes.dart';
import 'package:decordashapp/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class FadeAppBar extends StatelessWidget {
  final double scrollOffset;
  const FadeAppBar({super.key, required this.scrollOffset});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: TDeviceUtils.getScreenOrientation(context) == Orientation.portrait
          ? TDeviceUtils.getScreenHeight() * 0.1
          : TDeviceUtils.getScreenHeight() * 0.22,
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
                prefixIcon: Iconsax.search_normal_copy,
                readOnly: true,
                filled: true,
                onTap: () => Get.to(
                  () => const SearchScreen(),
                  duration: const Duration(milliseconds: 300),
                  transition: Transition.downToUp,
                ),
              )),
        ),
      ),
    );
  }
}
