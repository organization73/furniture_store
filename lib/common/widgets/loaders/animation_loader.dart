import 'package:flutter/material.dart';
import 'package:decordashapp/utils/constants/sizes.dart';
import 'package:lottie/lottie.dart';
import 'package:decordashapp/utils/device/device_utility.dart';

class AnimationLoaderWidget extends StatelessWidget {
  const AnimationLoaderWidget(
      {super.key,
      required this.text,
      required this.animation,
      this.showAction = false,
      this.actionText,
      this.onActionpress});

  final String text;
  final String animation;
  final bool showAction;
  final String? actionText;
  final VoidCallback? onActionpress;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Lottie.asset(
          animation,
          width: TDeviceUtils.getScreenHeight() * 0.8,
          height: TDeviceUtils.getScreenHeight() * 0.4,
        ),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        showAction
            ? OutlinedButton(
                onPressed: onActionpress,
                child: Text(actionText!,
                    style: Theme.of(context).textTheme.titleSmall))
            : const SizedBox.shrink()
      ],
    );
  }
}
