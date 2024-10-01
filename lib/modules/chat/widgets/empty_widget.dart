import 'package:decordashapp/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    super.key,
    required this.icon,
  });

  final IconData icon;

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: TSizes.iconLg * 4,
              color: Theme.of(context).colorScheme.surfaceContainerHigh,
            ),
          ],
        ),
      );
}
