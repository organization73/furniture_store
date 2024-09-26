// gallery_selection_model.dart

import 'package:get/get.dart';

class GallerySelectionModel extends GetxController {
  var selectedOption = 0.obs; // 0 represents "Yes", 1 represents "No"

  void selectOption(int option) {
    selectedOption.value = option;
  }
}
