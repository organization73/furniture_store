import 'package:flutter/material.dart';
import 'package:decordash/common/widgets/input_fields/build_user_input_field.dart';

import 'package:decordash/utils/validators/validation.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

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
