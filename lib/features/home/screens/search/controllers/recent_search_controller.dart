import 'dart:convert';
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
    query = query.trim();
    if (recentSearches.length >= 7) {
      // If it does, remove the oldest item before adding the new one
      recentSearches.removeAt(6);
    }

    if (recentSearches.contains(query)) {
      recentSearches.remove(query);
    }
    recentSearches.insert(0, query);

    if (recentSearches.contains(query)) {
      recentSearches.remove(query);
      recentSearches.insert(0, query);
      recentSearches.refresh();
    }
    saveRecentSearchesToStorage();
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
