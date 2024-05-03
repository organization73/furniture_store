import 'package:flutter/material.dart';

class CostomTextFormFild extends StatelessWidget {
  CostomTextFormFild(
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
      this.enabled = true,
      this.initialValue});
  String hint;
  IconData prefixIcon;
  IconData? suffixIcon;
  VoidCallback? onTapSuffixIcon;
  bool obscureText;
  bool filled;
  bool enabled;
  String? initialValue;

  TextEditingController? controller;
  Function()? onEditingComplete;

  String? Function(String?)? validator;
  Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        initialValue: initialValue,
        onEditingComplete: onEditingComplete,
        controller: controller,
        onChanged: onChanged,
        validator: validator,
        obscureText: obscureText,
        keyboardType: TextInputType.text,
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
          enabled: enabled,
        ),
      ),
    );
  }
}
