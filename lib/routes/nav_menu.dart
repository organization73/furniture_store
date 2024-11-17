import 'package:decordashapp/modules/chat/screens/chats_lists_screen.dart';
import 'package:flutter/material.dart';
import 'package:decordashapp/modules/home/screens/home_screen.dart';
import 'package:decordashapp/modules/store/screens/store_screen.dart';
import 'package:decordashapp/modules/settings/screens/settings_screen.dart';
import 'package:decordashapp/modules/product/screens/add_product/add_product_screen.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class NavMenu extends StatelessWidget {
  const NavMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GetBuilder<NavigationController>(
          builder: (controller) => NavigationBar(
                selectedIndex: controller.selectedIndex,
                indicatorColor: Colors.transparent,
                onDestinationSelected: (index) => controller.setIndex(index),
                destinations: [
                  NavigationDestination(
                    selectedIcon: Icon(
                      IconsaxPlusBold.home_1,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    icon: const Icon(IconsaxPlusLinear.home_1),
                    label: 'Home',
                  ),
                  NavigationDestination(
                    selectedIcon: Icon(
                      IconsaxPlusBold.shopping_bag,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    icon: const Icon(IconsaxPlusLinear.shopping_bag),
                    label: 'Store',
                  ),
                  NavigationDestination(
                    selectedIcon: Icon(
                      IconsaxPlusBold.add_square,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    icon: const Icon(IconsaxPlusLinear.add_square),
                    label: 'Add',
                  ),
                  NavigationDestination(
                    selectedIcon: Icon(
                      IconsaxPlusBold.message,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    icon: const Icon(IconsaxPlusLinear.message),
                    label: 'Chat',
                  ),
                  NavigationDestination(
                    selectedIcon: Icon(
                      IconsaxPlusBold.user,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    icon: const Icon(IconsaxPlusLinear.user),
                    label: 'Profile',
                  ),
                ],
              )),
      body: GetBuilder<NavigationController>(
          init: NavigationController(),
          builder: (controller) =>
              controller.screens[controller.selectedIndex]),
    );
  }
}

class NavigationController extends GetxController {
  int selectedIndex = 0;
  final screens = [
    const HomeScreen(),
    const StoreScreen(),
    const AddProductPage(),
    const ChatsListScreen(),
    const SettingsScreen(),
  ];
  void setIndex(int index) {
    selectedIndex = index;
    update();
  }
}
