import 'package:app/models/user.model.dart';
import 'package:app/screens/welcome.screen.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class AuthController extends GetxController {
  final String title = "AuthService";

  Rx<bool> _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(bool value) => this._isLoading.value = value;

  Rx<UserModel> _user = UserModel().obs;
  UserModel get user => _user.value;
  set user(UserModel value) => this._user.value = value;

  Future<void> silentLogin() async {
    Box box = Hive.box('USER');
    var authorization = box.get('authorization');
    if (authorization != null) {
      //API
      // Get.find<AuthService>().setUser(data);
    } else {
      isLoading = true;
      Future.delayed(
        Duration(seconds: 3),
        () {
          isLoading = false;
          Get.offNamed(WelcomeScreen.routeName);
        },
      );
    }
  }

  void signOut() async {
    Box box = Hive.box('USER');
    box.deleteAll(box.keys);
    Get.offNamed(WelcomeScreen.routeName);
  }
}
