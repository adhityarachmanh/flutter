/*
module  : AUTH PROVIDER
creator : adhityarachmanh
os      : darwin20
created : Sun May  9 15:19:54 WIB 2021
*/

import 'package:app/pages/welcome/page.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:app/models/user.model.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthService>(() => AuthService());
    print("AuthBinding");
  }
}

class AuthService extends GetxController {
  final String title = "AuthService";

  late UserModel? _user;
  UserModel? get user => _user;

  void setUser(UserModel? payload) async {
    _user = payload;
    update();
  }

  void signOut() async {
    Box box = Hive.box('USER');
    box.deleteAll(box.keys);
    setUser(null);
    Get.offNamed(WelcomePage.routeName);
  }
}
