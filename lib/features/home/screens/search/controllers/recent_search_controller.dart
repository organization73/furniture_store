import 'package:get/get.dart';

class RecentSearchController extends GetxController {
  static RecentSearchController get instance => Get.find();

  RxList recentSearchList = [].obs;

  void addRecentSearch(String search) {
    // Check if the search term already exists in the list
    if (recentSearchList.contains(search)) {
      // Option 1: Skip adding the search if it's already in the list
      // Option 2: Remove the existing search and add it again to move it to the end
      recentSearchList.remove(search);
    }

    // Ensure the list size does not exceed 5
    if (recentSearchList.length >= 5) {
      recentSearchList.removeAt(0); // Remove the oldest item
    }

    // Add the new search
    recentSearchList.add(search);
  }

  void removeRecentSearchItem(int index) {
    recentSearchList.removeAt(index);
  }
}
