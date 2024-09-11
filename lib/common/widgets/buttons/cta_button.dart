import 'package:decordashapp/utils/device/device_utility.dart';
import 'package:flutter/material.dart';

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
      width: TDeviceUtils.getScreenWidth(),
      child: OutlinedButton(
        onPressed: onPressed,
        child: Text(
          text,
        ),
      ),
    );
  }
}
