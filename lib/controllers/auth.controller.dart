/*
module  : AUTH PROVIDER
creator : adhityarachmanh
os      : darwin20
created : Sun May  9 15:19:54 WIB 2021
*/

import 'package:app/pages/welcome.page.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:app/models/user.model.dart';
import 'package:app/widgets/toast.widget.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
  }
}

class AuthController extends GetxController {
  final String title = "AuthProvider";

  late List<String> _errors = [];
  List<String> get errors => _errors;
  late UserModel _user;
  UserModel get user => _user;

  void setError(List<String> list) async {
    _errors = list;
    update();
  }

  void userInfo(UserModel payload) async {
    _user = payload;
    update();
  }

  Future<void> signIn(
    String username,
    String password,
  ) async {
    List<String> errorList = [];
    if (username == "") errorList.add("username");
    if (password == "") errorList.add("password");
    setError(errorList);
    if (errorList.length != 0) return;
    try {
      //API

    } catch (e) {
      showToast("Server Error!");
    }
  }

  void signOut() async {
    Box box = Hive.box('USER');
    box.deleteAll(box.keys);
    Get.offNamed(WelcomePage.routeName);
  }

  Future<void> silentLogin() async {
    Box box = Hive.box('USER');
    var authorization = box.get('authorization');
    if (authorization != null) {
      try {
        //API

      } catch (e) {}
    } else {
      Get.offNamed(WelcomePage.routeName);
    }
  }
}
