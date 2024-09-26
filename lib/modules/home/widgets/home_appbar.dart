import 'package:flutter/material.dart';
import 'package:decordashapp/modules/favourits/screens/favourite_screen.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

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
                  () => const FavouritsPage(),
                  duration: const Duration(milliseconds: 300),
                  transition: Transition.downToUp,
                ),
            icon: const Icon(
              Iconsax.heart_copy,
            )),
      ],
    );
  }
}
