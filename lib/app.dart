import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furniture_store/bindings/general_bindings.dart';
import 'package:furniture_store/localization/language_keys.dart';
import 'package:furniture_store/utils/theme/theme.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
            initialBinding: GeneralBinding(),
            debugShowCheckedModeBanner: false,
            title: 'Furniture Store',
            locale: const Locale('en', 'US'), // Set the default locale
            fallbackLocale: const Locale('en', 'US'), // Set the fallback locale
            translations: Language(),
            themeMode: ThemeMode.system,
            theme: TAppTheme.lightTheme,
            darkTheme: TAppTheme.darkTheme,
            home: const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ));
      },
    );
  }
}
