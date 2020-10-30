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
