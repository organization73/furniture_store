import 'package:decordashapp/utils/constants/sizes.dart';
import 'package:decordashapp/utils/device/device_utility.dart';
import 'package:flutter/material.dart';

class UploadGalleryInfo extends StatelessWidget {
  const UploadGalleryInfo({
    super.key,
    required this.onTap,
    required this.title,
    required this.icon,
  });

  final VoidCallback onTap;
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: TDeviceUtils.getScreenHeight(context) * 0.12,
          decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              border: Border.all(
                width: 0.5,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(15))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: TSizes.iconLg * 1.5,
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.labelSmall,
              )
            ],
          ),
        ),
      ),
    );
  }
}
