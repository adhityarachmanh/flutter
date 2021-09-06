/*
module  : MAIN
creator : adhityarachmanh
os      : darwin19
created : Thu May  6 12:21:22 WIB 2021
*/
import 'dart:async';
import 'package:app/controllers/auth.controller.dart';
import 'package:app/pages/privacyandpolicy.page.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:app/pages.dart';
import 'package:app/pages/splash.page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  // HIVE
  await Hive.initFlutter();
  await Hive.openBox('GUEST');
  await Hive.openBox('USER');
  runApp(Main());
}

Future<void> initialize() async {
  Box box = Hive.box('GUEST');
  final authController = Get.put(AuthController());
  // box.deleteAll(box.keys);
  Timer(Duration(seconds: 3), () async {
    bool privacyAndPolicy = box.get('privacyAndPolicy', defaultValue: false);

    if (privacyAndPolicy) {
      await authController.silentLogin();
    } else {
      Get.offNamed(PrivacyAndPolicyPage.routeName);
    }
  });
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: initialize(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: const MaterialColor(
                0xff9c27b0,
                const <int, Color>{
                  50: const Color(0xff9c27b0),
                  100: const Color(0xff9c27b0),
                  200: const Color(0xff9c27b0),
                  300: const Color(0xff9c27b0),
                  400: const Color(0xff9c27b0),
                  500: const Color(0xff9c27b0),
                  600: const Color(0xff9c27b0),
                  700: const Color(0xff9c27b0),
                  800: const Color(0xff9c27b0),
                  900: const Color(0xff9c27b0),
                },
              ),
            ),
            initialRoute: SplashPage.routeName,
            getPages: pages,
          );
        });
  }
}
