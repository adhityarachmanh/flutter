/*
module  : AUTH PROVIDER
creator : adhityarachmanh
os      : darwin20
created : Sun May  9 15:19:54 WIB 2021
*/
import 'package:get/get.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    print("DashboardBinding");
    Get.lazyPut<DashboardController>(() => DashboardController());
  }
}

class DashboardController extends GetxController {
  final String title = "Dashboard Controller!";
}
