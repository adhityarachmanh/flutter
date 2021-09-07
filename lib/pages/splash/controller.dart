import 'dart:async';
import 'package:app/pages/PrivacyAndPolicy/page.dart';
import 'package:app/pages/welcome/page.dart';
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

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setLoading(status) {
    _isLoading = status;
    update();
  }

  Future<void> silentLogin() async {
    Box box = Hive.box('USER');
    var authorization = box.get('authorization');
    setLoading(true);
    if (authorization != null) {
      //API
      // Get.find<AuthService>().setUser(data);
    } else {
      Future.delayed(Duration(seconds: 3), () {
        Get.offNamed(WelcomePage.routeName);
        setLoading(false);
      });
    }
  }

  Future<void> initialize() async {
    Box box = Hive.box('GUEST');

    // box.deleteAll(box.keys);
    Timer(Duration(seconds: 3), () async {
      bool privacyAndPolicy = box.get('privacyAndPolicy', defaultValue: false);
      if (privacyAndPolicy) {
        await silentLogin();
      } else {
        Get.offNamed(PrivacyAndPolicyPage.routeName);
      }
    });
  }
}
