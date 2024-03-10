import 'dart:io';
import 'package:get/get.dart';

class GalleryInformationModel extends GetxController {
  var selectedImage = Rx<File?>(null);

  void updateSelectedImage(File? file) {
    selectedImage.value = file;
  }
}
