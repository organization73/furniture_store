import 'package:flutter/material.dart';
import 'package:furniture_store/common/widgets/build_user_input_field.dart';

import 'package:furniture_store/utils/validators/validation.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class BuildSearchBar extends StatelessWidget {
  const BuildSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    return SizedBox(
      height: 42,
      child: RoundedTextField(
          prefixIcon: Iconsax.search_normal,
          'homeSearchBarHint'.tr,
          keyboardType: TextInputType.text,
          showLabel: false,
          isFilled: true,
          fillColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.4),
          controller,
          TValidator.validateUserInput),
    );
  }
}
