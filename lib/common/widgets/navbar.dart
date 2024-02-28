import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomNav extends StatelessWidget {
  final int currentPageIndex;
  final Function(int) onDestinationSelected;

  const CustomNav({
    super.key,
    required this.currentPageIndex,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      onDestinationSelected: onDestinationSelected,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      selectedIndex: currentPageIndex,
      elevation: 0,
      indicatorColor: Colors.transparent,
      destinations: <Widget>[
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
    );
  }
}
