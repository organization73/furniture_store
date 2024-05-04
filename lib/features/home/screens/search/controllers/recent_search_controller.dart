import 'dart:convert';

import 'package:decordash/common/widgets/loaders/loaders.dart';
import 'package:decordash/utils/local_storage/storage_utility.dart';
import 'package:get/get.dart';

class RecentSearchController extends GetxController {
  static RecentSearchController get instance => Get.find();

  final recentSearches = <String>[].obs;

  @override
  onInit() {
    super.onInit();
    initRecentSearches();
  }

  void initRecentSearches() {
    final json = TLocalStorage.instance().readData('recentSearches');
    if (json != null) {
      final storedSearches = jsonDecode(json) as List<dynamic>;
      recentSearches.addAll(storedSearches.cast<String>());
    }
  }

  void addSearch(String query) {
  if (!recentSearches.contains(query)) {
    // Check if the list already contains 5 items
    if (recentSearches.length >= 5) {
      // If it does, remove the oldest item before adding the new one
      recentSearches.removeAt(0);
    }
    // Add the new search query to the list
    recentSearches.add(query);
    saveRecentSearchesToStorage();
    TLoaders.customToast(
        messege: 'Search query has been added to recent searches');
  } else {
    TLoaders.customToast(
        messege: 'Search query is a duplicate. Cannot add duplicates.');
  }
}


  void removeSearch(int query) {
    recentSearches.removeAt(query);
    saveRecentSearchesToStorage();
    recentSearches.refresh();
    TLoaders.customToast(
        messege: 'Search query has been removed from recent searches');
  }

  void displayRecentSearches() {
    // Assuming you have a method to display the list of recent searches
    // This could be a simple print statement or a more complex UI update
    print(recentSearches);
  }

  void saveRecentSearchesToStorage() {
    final encodedRecentSearches = json.encode(recentSearches.toList());
    TLocalStorage.instance().saveData('recentSearches', encodedRecentSearches);
  }
}
