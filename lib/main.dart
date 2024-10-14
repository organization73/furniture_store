import 'package:decordashapp/app.dart';
import 'package:decordashapp/data/repositories/authentication/authentication_repo.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'firebase_options.dart';

Future<void> main() async {
  final WidgetsBinding widgetBind = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetBind);

  await Future.wait([
    GetStorage.init(),
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
    FirebaseAppCheck.instance.activate(androidProvider: AndroidProvider.debug),
    FirebaseMessaging.instance.getInitialMessage(),
  ]).then((value) => Get.put(AuthenticatorRepo()));

  runApp(const MyApp());
}
