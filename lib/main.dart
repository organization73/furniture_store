import 'package:decordash/app.dart';
import 'package:decordash/data/repositories/authentication/authentication_repo.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'firebase_options.dart';

Future<void> main() async {
  final WidgetsBinding widgetBind = WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await ScreenUtil.ensureScreenSize();
  FlutterNativeSplash.preserve(widgetsBinding: widgetBind);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseAppCheck.instance
      .activate(
        androidProvider: AndroidProvider.debug,
      )
      .then((value) => Get.put(AuthenticatorRepo()));
  runApp(const MyApp());
}
//