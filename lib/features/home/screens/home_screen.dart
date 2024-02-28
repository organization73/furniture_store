import 'package:flutter/material.dart';
import 'package:furniture_store/common/widgets/navbar.dart';
import 'package:furniture_store/features/chat/screens/chats_screen.dart';
import 'package:furniture_store/features/product/screens/add_product/add_product_screen.dart';
import 'package:furniture_store/features/ai/screens/ai_design_screen.dart';
import 'package:furniture_store/features/personalization/screens/settings/settings.dart';
import 'package:furniture_store/features/home/screens/start_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.initialPageIndex});

  final int initialPageIndex;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int currentPageIndex;

  @override
  void initState() {
    super.initState();
    currentPageIndex = widget.initialPageIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      bottomNavigationBar: CustomNav(
        currentPageIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
      ),
      body: IndexedStack(
        index: currentPageIndex,
        children: const [
          StartPage(),
          ChatScreen(),
          AddProductPage(),
          AiPage(),
          SettingsScreen(),
        ],
      ),
    );
  }
}
