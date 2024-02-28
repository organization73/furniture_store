import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
          selectedIcon: SvgPicture.asset(
            'assets/icons/home_active.svg',
          ),
          icon: SvgPicture.asset(
            'assets/icons/home_unactive.svg',
          ),
          label: 'Home',
        ),
        NavigationDestination(
          selectedIcon: SvgPicture.asset(
            'assets/icons/chat_active.svg',
          ),
          icon: SvgPicture.asset(
            'assets/icons/chat_unactive.svg',
          ),
          label: 'Chat',
        ),
        NavigationDestination(
          selectedIcon: SvgPicture.asset(
            'assets/icons/add_active.svg',
          ),
          icon: SvgPicture.asset(
            'assets/icons/add_unactive.svg',
          ),
          label: 'Add',
        ),
        NavigationDestination(
          selectedIcon: SvgPicture.asset(
            'assets/icons/ai_active.svg',
          ),
          icon: SvgPicture.asset(
            'assets/icons/ai_unactive.svg',
          ),
          label: 'AI',
        ),
        NavigationDestination(
          selectedIcon: SvgPicture.asset(
            'assets/icons/profile_active.svg',
          ),
          icon: SvgPicture.asset(
            'assets/icons/profile_unactive.svg',
          ),
          label: 'Profile',
        ),
      ],
    );
  }
}
