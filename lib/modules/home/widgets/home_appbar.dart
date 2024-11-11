import 'package:flutter/material.dart';
import 'package:decordashapp/modules/favourites/screens/favourites_screen.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text('homeAppbarTitle'.tr,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleLarge),
        ),
        IconButton(
            onPressed: () => Get.to(
                  () => const FavouritesScreen(),
                  transition: Transition.downToUp,
                ),
            icon: const Icon(
              IconsaxPlusLinear.heart,
            )),
      ],
    );
  }
}
