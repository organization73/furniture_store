import 'package:flutter/material.dart';
import 'package:decordashapp/utils/constants/sizes.dart';

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
  final bool isReadonly;
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
    this.isReadonly = false,
    this.fillColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      obscureText: isPassword,
      style: const TextStyle(
        fontSize: 12,
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
      readOnly: isReadonly,
    );
  }
}
