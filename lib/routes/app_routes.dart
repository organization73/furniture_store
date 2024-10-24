import 'package:decordashapp/modules/chat/screens/chats_lists_screen.dart';
import 'package:decordashapp/modules/favourites/screens/favourites_screen.dart';
import 'package:decordashapp/modules/home/screens/home_screen.dart';
import 'package:decordashapp/modules/home/screens/search/search_screen.dart';
import 'package:decordashapp/modules/settings/screens/settings_screen.dart';
import 'package:decordashapp/modules/store/screens/store_screen.dart';
import 'package:decordashapp/routes/routes.dart';
import 'package:get/get.dart';

class AppRoutes {
  static final pages = [
    GetPage(name: TRoutes.home, page: () => const HomeScreen()),
    GetPage(name: TRoutes.store, page: () => const StoreScreen()),
    GetPage(name: TRoutes.favourites, page: () => const FavouritesScreen()),
    GetPage(name: TRoutes.settings, page: () => const SettingsScreen()),
    GetPage(name: TRoutes.search, page: () => const SearchScreen()),
    GetPage(name: TRoutes.chat, page: () => const ChatsListScreen()),
  ];
}
