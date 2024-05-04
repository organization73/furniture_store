import 'package:decordash/features/home/screens/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:decordash/utils/constants/sizes.dart';
import 'package:get/get.dart';

class RoundedTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final FormFieldValidator<String?> validator;
  final bool isPassword;
  final TextInputType keyboardType;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool showLabel;
  final bool isFilled;
  final Color? fillColor;

  const RoundedTextField(
    this.hintText,
    this.controller,
    this.validator, {
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.suffixIcon,
    super.key,
    this.showLabel = true,
    this.isFilled = false,
    this.fillColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      obscureText: isPassword,
      onTap: () => Get.to(
        () => const SearchScreen(),
        duration: const Duration(milliseconds: 300),
        transition: Transition.downToUp,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        filled: isFilled,
        fillColor: fillColor,
        label: showLabel ? Text(hintText) : null,
        prefixIcon: prefixIcon != null
            ? Icon(
                  prefixIcon,
                  size: TSizes.iconMd,
                )
            : null,
        suffixIcon: suffixIcon,
      ),
      validator: validator,
    );
  }
}
