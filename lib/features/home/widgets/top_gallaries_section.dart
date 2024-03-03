import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furniture_store/features/gallery/screens/all_galleries/all_galleries_screen.dart';
import 'package:furniture_store/utils/constants/image_strings.dart';
import 'package:furniture_store/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

final Map<String, String> listIteams = {
  'Mohammed': TImages.user,
  'Khaled Ali': TImages.user,
  'Samy': TImages.user,
};

class BuildTopGalleriesSection extends StatelessWidget {
  const BuildTopGalleriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'topGalleries'.tr,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const Spacer(),
            TextButton(
              onPressed: () => Get.to(
                () => const AllGalleriesPage(),
                duration: const Duration(milliseconds: 300),
                transition: Transition.rightToLeft,
              ),
              child: Row(
                children: [
                  Text(
                    'seeAll'.tr,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  const SizedBox(
                    width: TSizes.sm,
                  ),
                  const Icon(
                    Iconsax.arrow_right_1,
                    size: TSizes.iconSm,
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: listIteams.entries.map((entry) {
            var sectionName = entry.key;
            var image = entry.value;

            return Column(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(image),
                  radius: 35,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(sectionName,
                    style: Theme.of(context).textTheme.bodyMedium),
              ],
            );
          }).toList(),
        ),
        SizedBox(
          height: TSizes.spaceBtwSections,
        ),
      ],
    );
  }
}
