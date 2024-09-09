import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:decordashapp/utils/theme/theme.dart';
import 'package:get/get.dart';

AppBar buildAppBar(BuildContext context) {
  const icon = CupertinoIcons.moon_stars;
  return AppBar(
    actions: [
      IconButton(
        onPressed: () {
          Get.changeTheme(
              Get.isDarkMode ? TAppTheme.lightTheme : TAppTheme.darkTheme);
        },
        icon: const Icon(icon),
      )
    ],
  );
}
