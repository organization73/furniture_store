import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      required this.hint,
      this.suffixIcon,
      this.onTapSuffixIcon,
      this.obscureText = false,
      this.validator,
      this.onChanged,
      this.onEditingComplete,
      this.controller,
      required this.prefixIcon,
      this.filled = false,
      this.onTap,
      this.readOnly = false});
  final String hint;
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onTapSuffixIcon;
  final bool obscureText;
  final bool filled;
  final VoidCallback? onTap;
  final bool readOnly;

  final TextEditingController? controller;
  final Function()? onEditingComplete;

  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onEditingComplete: onEditingComplete,
      controller: controller,
      onChanged: onChanged,
      validator: validator,
      obscureText: obscureText,
      keyboardType: TextInputType.text,
      readOnly: readOnly,
      onTap: onTap,
      decoration: InputDecoration(
        fillColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.4),
        hintText: hint,
        prefixIcon: Icon(
          prefixIcon,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            suffixIcon,
          ),
          onPressed: onTapSuffixIcon,
        ),
        filled: filled,
      ),
    );
  }
}
