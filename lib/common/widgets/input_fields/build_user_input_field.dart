import 'package:flutter/material.dart';
import 'package:decordash/utils/constants/sizes.dart';

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
  final Function()? onPressedPrefixIcon;

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
    this.onPressedPrefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      obscureText: isPassword,
      onChanged: (value) => print(value),
      onTap: () => print(8888888888),
      decoration: InputDecoration(
        hintText: hintText,
        filled: isFilled,
        fillColor: fillColor,
        label: showLabel ? Text(hintText) : null,
        prefixIcon: prefixIcon != null
            ? IconButton(
                icon: Icon(
                  prefixIcon,
                  size: TSizes.iconMd,
                ),
                onPressed: onPressedPrefixIcon,
              )
            : null,
        suffixIcon: suffixIcon,
      ),
      validator: validator,
    );
  }
}
