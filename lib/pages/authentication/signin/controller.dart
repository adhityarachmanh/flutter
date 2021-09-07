/*
module  : AUTH PROVIDER
creator : adhityarachmanh
os      : darwin20
created : Sun May  9 15:19:54 WIB 2021
*/
import 'package:get/get.dart';

class SignInBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignInController>(() => SignInController());
    print("SignInBinding");
  }
}

class SignInController extends GetxController {
  final String title = "SignIn Controller!";
}
