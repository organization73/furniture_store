import 'package:flutter/material.dart';
import 'package:furniture_store/features/favourits/screens/favourite_screen.dart';
import 'package:furniture_store/features/notifications/controllers/notifications_controller.dart';
import 'package:furniture_store/features/notifications/screens/notifications_screen.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
    required this.controller,
  });

  final NotificationsController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            'homeAppbarTitle'.tr,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        IconButton(
            onPressed: () => Get.to(
                  () => const FavouritsPage(),
                  duration: const Duration(milliseconds: 300),
                  transition: Transition.downToUp,
                ),
            icon: const Icon(
              Iconsax.heart,
            )),
        Obx(
          () => IconButton(
            onPressed: () => Get.to(
              () => const NotificationsPage(),
              duration: const Duration(milliseconds: 300),
              transition: Transition.downToUp,
            ),
            icon: Badge(
                backgroundColor:
                    Theme.of(context).colorScheme.onPrimaryContainer,
                label: Text('${controller.notiList.length}'),
                child: (controller.notiList.isEmpty)
                    ? Icon(
                        Iconsax.notification,
                        color: Theme.of(context).disabledColor,
                      )
                    : const Icon(
                        Iconsax.notification5,
                      )),
          ),
        )
      ],
    );
  }
}
