import 'package:flutter/material.dart';

class BuildCTAButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final dynamic routeName;

  const BuildCTAButton({
    super.key,
    required this.text,
    this.onPressed,
    this.routeName,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          text,
        ),
      ),
    );
  }
}
