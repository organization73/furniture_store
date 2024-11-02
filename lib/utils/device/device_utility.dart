import 'package:flutter/material.dart';

class TDeviceUtils {
  static Orientation getScreenOrientation(BuildContext context) {
    return MediaQuery.of(context).orientation;
  }

  static double getScreenHeight(BuildContext context) {
    return MediaQuery.sizeOf(context).height;
  }

  static double getScreenWidth(BuildContext context) {
    return MediaQuery.sizeOf(context).width;
  }

  static double getStatusBarHeight(BuildContext context) {
    return MediaQuery.paddingOf(context).top;
  }

  static double getAppBarHeight() {
    return kToolbarHeight;
  }
}
