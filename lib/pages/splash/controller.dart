import 'dart:async';

import 'package:app/controllers/auth.controller.dart';
import 'package:app/pages/PrivacyAndPolicy/page.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController());
    print("SplashBinding");
  }
}

class SplashController extends GetxController {
  final String title = "Splash Controller!";
  Future<void> initialize() async {
    Box box = Hive.box('GUEST');
    AuthController authController = Get.put(AuthController());
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
}
