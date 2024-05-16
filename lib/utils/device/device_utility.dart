import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TDeviceUtils {
  static double getAppBarHeight() {
    return kToolbarHeight;
  }

  static double getKeyboardHeight() {
    final viewInsets = MediaQuery.of(Get.context!).viewInsets;
    return viewInsets.bottom;
  }
}
