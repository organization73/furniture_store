import 'package:flutter/material.dart';
import 'package:decordash/features/ai/screens/ai_design_screen.dart';
import 'package:decordash/features/chat/screens/chats_screen.dart';
import 'package:decordash/features/home/screens/start_screen.dart';
import 'package:decordash/features/store/screens/store_screen.dart';
import 'package:decordash/features/personalization/screens/settings/settings.dart';
import 'package:decordash/features/product/screens/add_product/add_product_screen.dart';
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
                  Iconsax.message_copy,
                  color: Theme.of(context).colorScheme.primary,
                ),
                icon: const Icon(Iconsax.message_copy),
                label: 'Chat',
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
                  Iconsax.d_cube_scan_copy,
                  color: Theme.of(context).colorScheme.primary,
                ),
                icon: const Icon(Iconsax.d_cube_scan_copy),
                label: 'AI',
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
    const StartPage(),
    const StoreScreen(),
    const ChatScreen(),
    const AddProductPage(),
    const AiPage(),
    const SettingsScreen(),
  ];
}
