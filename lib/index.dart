/*
module  : INDEX
creator : adhityarachmanh
os      : darwin19
created : Thu Dec 17 20:21:01 WIB 2020
product : ARH
version : v1.0
*/

part of 'app.dart';

class IndexController with ChangeNotifier {
  UserModel _user;
  UserModel get user => _user;

  void userInfo(UserModel payload) {
    _user = payload;
    notifyListeners();
  }
  
  void onInit(){
      print("init IndexController");
  }
}
