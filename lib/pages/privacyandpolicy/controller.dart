/*
module  : AUTH PROVIDER
creator : adhityarachmanh
os      : darwin20
created : Sun May  9 15:19:54 WIB 2021
*/
import 'package:app/pages/welcome/page.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class PrivacyAndPolicyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PrivacyAndPolicyController>(() => PrivacyAndPolicyController());
    print("PrivacyAndPolicyBinding");
  }
}

class PrivacyAndPolicyController extends GetxController {
  final String title = "PrivacyAndPolicy Controller!";
  void aggree() async {
    Box box = Hive.box('GUEST');
    box.put("privacyAndPolicy", true);
    Get.offNamed(WelcomePage.routeName);
  }
}
