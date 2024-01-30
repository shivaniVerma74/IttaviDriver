// ignore_for_file: prefer_const_constructors

import 'package:deliveryboy/helpar/routes_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'helpar/get_di.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  await di.init();
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize("cab58f9d-996e-4c97-8175-1cc4b7eab192");
  OneSignal.Notifications.requestPermission(true);
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        fontFamily: "Gilroy",
      ),
      initialRoute: Routes.initial,
      getPages: getPages,
    ),
  );
}
