import 'package:decordash/bindings/general_bindings.dart';
import 'package:decordash/localization/language_keys.dart';
import 'package:decordash/provider/firebase_provider.dart';
import 'package:decordash/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return ChangeNotifierProvider(
          create: (BuildContext context) {
            return FirebaseProvider();
          },
          child: GetMaterialApp(
              initialBinding: GeneralBinding(),
              debugShowCheckedModeBanner: false,
              title: 'Decor Dash',
              locale: const Locale('en', 'US'),
              fallbackLocale: const Locale('en', 'US'),
              translations: Language(),
              themeMode: ThemeMode.system,
              theme: TAppTheme.lightTheme,
              darkTheme: TAppTheme.darkTheme,
              home: const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              )),
        );
      },
    );
  }
}
