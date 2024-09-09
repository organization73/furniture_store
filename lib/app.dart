import 'package:decordashapp/bindings/general_bindings.dart';
import 'package:decordashapp/localization/language_keys.dart';
import 'package:decordashapp/utils/theme/theme.dart';
import 'package:decordashapp/utils/theme/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieves the default theme for the platform
    //TextTheme textTheme = Theme.of(context).textTheme;

    // Use with Google Fonts package to use downloadable fonts
    TextTheme textTheme = createTextTheme(context, "Poppins", "Poppins");

    MaterialTheme theme = MaterialTheme(textTheme);
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
            initialBinding: GeneralBinding(),
            debugShowCheckedModeBanner: false,
            title: 'Decor Dash',
            locale: Get.deviceLocale,
            fallbackLocale: const Locale('en', 'US'),
            translations: Language(),
            themeMode: ThemeMode.system,
            theme: theme.light(),
            darkTheme: theme.dark(),
            home: const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ));
      },
    );
  }
}
