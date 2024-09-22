import 'package:decordashapp/common/widgets/images/rounded_image.dart';
import 'package:decordashapp/utils/constants/sizes.dart';
import 'package:decordashapp/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:decordashapp/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:decordashapp/features/home/model/category_model.dart';

class HorizontalCategory extends StatelessWidget {
  const HorizontalCategory(
      {super.key, required this.onTap, required this.category});
  final VoidCallback onTap;
  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: RoundedContainer(
          width: TDeviceUtils.getScreenWidth() * 0.31,
          margin: const EdgeInsets.only(right: TSizes.spaceBtwItems),
          backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
          raduis: 8,
          padding: const EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(category.name,
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.titleSmall),
              RoundedImage(
                imageUrl: category.image,
                isNetworkImage: true,
                applyImageRaduis: false,
                height: 60,
                width: 60,
                padding: const EdgeInsets.all(5),
              ),
            ],
          ),
        ));
  }
}
