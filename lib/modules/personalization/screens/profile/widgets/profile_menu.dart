import 'package:flutter/material.dart';
import 'package:decordashapp/utils/constants/sizes.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    super.key,
    this.icon = IconsaxPlusLinear.arrow_right_3,
    required this.onPress,
    required this.title,
    required this.value,
    this.showIcon = false,
  });

  final IconData icon;
  final bool showIcon;
  final VoidCallback onPress;
  final String title, value;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Padding(
        padding: const EdgeInsets.all(TSizes.spaceBtwItems / 1.5),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodySmall,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              flex: 5,
              child: Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              child: showIcon
                  ? Icon(
                      icon,
                      size: TSizes.iconSm,
                    )
                  : const SizedBox(),
            )
          ],
        ),
      ),
    );
  }
}
