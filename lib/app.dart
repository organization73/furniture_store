import 'package:decordashapp/bindings/general_bindings.dart';
import 'package:decordashapp/localization/language_keys.dart';
import 'package:decordashapp/utils/theme/theme.dart';
import 'package:decordashapp/utils/theme/util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = createTextTheme(context, "Poppins", "Poppins");
    MaterialTheme theme = MaterialTheme(textTheme);

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
  }
}
