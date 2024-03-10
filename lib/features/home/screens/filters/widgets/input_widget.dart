import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  final String hintText;
  final IconData prefixIcon;
  final double height;
  const InputWidget(
      {super.key,
      required this.hintText,
      required this.prefixIcon,
      this.height = 53.0});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.only(
        right: 16.0,
        left: 0.0,
      ),
      child: TextFormField(
        decoration: InputDecoration(
          prefixIcon: Icon(
            prefixIcon,
          ),
          hintText: hintText,
        ),
      ),
    );
  }
}
