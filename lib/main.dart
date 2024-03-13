import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furniture_store/app.dart';
import 'package:get_storage/get_storage.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

Future<void> main() async {
 

  final WidgetsBinding widgetBind = WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();
  await ScreenUtil.ensureScreenSize();

  FlutterNativeSplash.preserve(widgetsBinding: widgetBind);

  runApp(const MyApp());
}
