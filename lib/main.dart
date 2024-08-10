import 'package:decordash/app.dart';
import 'package:decordash/data/repositories/authentication/authentication_repo.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'firebase_options.dart';

// Future<void> _backgroundMessageHandler(RemoteMessage message) async {
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
// }

Future<void> main() async {
  final WidgetsBinding widgetBind = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetBind);

  await GetStorage.init();
  await ScreenUtil.ensureScreenSize();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseMessaging.instance
      .getInitialMessage()
      .then((value) => Get.put(AuthenticatorRepo()));

  // FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);

  runApp(const MyApp());
}
