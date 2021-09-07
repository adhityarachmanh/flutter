/*
module  : AUTH PROVIDER
creator : adhityarachmanh
os      : darwin20
created : Sun May  9 15:19:54 WIB 2021
*/
import 'package:get/get.dart';

class WelcomeBinding extends Bindings {
  @override
  void dependencies() {
    print("WelcomeBinding");
    Get.lazyPut<WelcomeController>(() => WelcomeController());
  }
}

class WelcomeController extends GetxController {
  final String title = "Welcome Controller!";
}
