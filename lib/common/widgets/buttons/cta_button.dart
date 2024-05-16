import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildCTAButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;

  const BuildCTAButton({
    super.key,
    required this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1.sw,
      child: OutlinedButton(
        onPressed: onPressed,
        child: Text(
          text,
        ),
      ),
    );
  }
}
