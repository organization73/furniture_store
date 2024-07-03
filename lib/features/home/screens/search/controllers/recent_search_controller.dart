import 'dart:convert';
import 'package:decordash/utils/local_storage/storage_utility.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class RecentSearchController extends GetxController {
  static RecentSearchController get instance => Get.find();

  final recentSearches = <String>[].obs;

  @override
  onInit() {
    super.onInit();
    initRecentSearches();
  }

  void initRecentSearches() {
    // TODO TLOCAl

    final json = GetStorage().read("recentSearches");
    if (json != null) {
      final storedSearches = jsonDecode(json) as List<dynamic>;
      recentSearches.addAll(storedSearches.cast<String>());
    }
  }

  void addSearch(String query) {
    if (!recentSearches.contains(query)) {
      // Check if the list already contains 5 items
      if (recentSearches.length >= 7) {
        // If it does, remove the oldest item before adding the new one
        recentSearches.removeAt(0);
      }
      // Add the new search query to the list
      recentSearches.insert(0, query);
      saveRecentSearchesToStorage();
    }
  }

  void removeSearch(int query) {
    recentSearches.removeAt(query);
    saveRecentSearchesToStorage();
    recentSearches.refresh();
  }

  void saveRecentSearchesToStorage() {
    final encodedRecentSearches = json.encode(recentSearches.toList());
    // TODO TLOCAl
    GetStorage().write("recentSearches", encodedRecentSearches);
    print("Recent searches saved to storage");
  }
}
