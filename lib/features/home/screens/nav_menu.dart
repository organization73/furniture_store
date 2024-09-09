import 'package:decordashapp/features/chat/screens/chats_screen.dart';
import 'package:flutter/material.dart';
import 'package:decordashapp/features/home/screens/home_screen.dart';
import 'package:decordashapp/features/store/screens/store_screen.dart';
import 'package:decordashapp/features/personalization/screens/settings/settings.dart';
import 'package:decordashapp/features/product/screens/add_product/add_product_screen.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class NavMenu extends StatelessWidget {
  const NavMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    return Scaffold(
      bottomNavigationBar: Obx(() => NavigationBar(
            elevation: 0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
            selectedIndex: controller.selectedIndex.value,
            indicatorColor: Colors.transparent,
            onDestinationSelected: (index) =>
                controller.selectedIndex.value = index,
            destinations: [
              NavigationDestination(
                selectedIcon: Icon(
                  Iconsax.home_copy,
                  color: Theme.of(context).colorScheme.primary,
                ),
                icon: const Icon(Iconsax.home_copy),
                label: 'Home',
              ),
              NavigationDestination(
                selectedIcon: Icon(
                  Iconsax.bag_2_copy,
                  color: Theme.of(context).colorScheme.primary,
                ),
                icon: const Icon(Iconsax.bag_2_copy),
                label: 'Store',
              ),
              NavigationDestination(
                selectedIcon: Icon(
                  Iconsax.add_square_copy,
                  color: Theme.of(context).colorScheme.primary,
                ),
                icon: const Icon(Iconsax.add_square_copy),
                label: 'Add',
              ),
              NavigationDestination(
                selectedIcon: Icon(
                  Iconsax.message_copy,
                  color: Theme.of(context).colorScheme.primary,
                ),
                icon: const Icon(Iconsax.message_copy),
                label: 'Chat',
              ),
              NavigationDestination(
                selectedIcon: Icon(
                  Iconsax.user_copy,
                  color: Theme.of(context).colorScheme.primary,
                ),
                icon: const Icon(Iconsax.user_copy),
                label: 'Profile',
              ),
            ],
          )),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final RxInt selectedIndex = 0.obs;
  final screens = [
    const HomeScreen(),
    const StoreScreen(),
    const AddProductPage(),
    const ChatsScreen(),
    const SettingsScreen(),
  ];
}
