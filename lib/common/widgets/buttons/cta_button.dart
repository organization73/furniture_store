import 'package:decordashapp/utils/device/device_utility.dart';
import 'package:flutter/material.dart';

class BuildCTAButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final bool isfilled;

  const BuildCTAButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isfilled = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: TDeviceUtils.getScreenWidth(context),
      child: isfilled
          ? FilledButton(
              onPressed: onPressed,
              child: Text(text),
            )
          : OutlinedButton(
              onPressed: onPressed,
              child: Text(text),
            ),
    );
  }
}
