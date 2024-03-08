import 'package:flutter/material.dart';
import 'package:furniture_store/features/ai/screens/ai_design_screen.dart';
import 'package:furniture_store/features/chat/screens/chats_screen.dart';
import 'package:furniture_store/features/home/screens/start_screen.dart';
import 'package:furniture_store/features/home/screens/store_screen.dart';
import 'package:furniture_store/features/personalization/screens/settings/settings.dart';
import 'package:furniture_store/features/product/screens/add_product/add_product_screen.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

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
                  Iconsax.home,
                  color: Theme.of(context).colorScheme.primary,
                ),
                icon: const Icon(Iconsax.home),
                label: 'Home',
              ),
              NavigationDestination(
                selectedIcon: Icon(
                  Iconsax.shop,
                  color: Theme.of(context).colorScheme.primary,
                ),
                icon: const Icon(Iconsax.shop),
                label: 'Store',
              ),
              NavigationDestination(
                selectedIcon: Icon(
                  Iconsax.message,
                  color: Theme.of(context).colorScheme.primary,
                ),
                icon: const Icon(Iconsax.message),
                label: 'Chat',
              ),
              NavigationDestination(
                selectedIcon: Icon(
                  Iconsax.add_square,
                  color: Theme.of(context).colorScheme.primary,
                ),
                icon: const Icon(Iconsax.add_square),
                label: 'Add',
              ),
              NavigationDestination(
                selectedIcon: Icon(
                  Iconsax.sound,
                  color: Theme.of(context).colorScheme.primary,
                ),
                icon: const Icon(Iconsax.sound),
                label: 'AI',
              ),
              NavigationDestination(
                selectedIcon: Icon(
                  Iconsax.user,
                  color: Theme.of(context).colorScheme.primary,
                ),
                icon: const Icon(Iconsax.user),
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
