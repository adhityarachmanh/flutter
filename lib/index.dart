part of 'app.dart';

class IndexController with ChangeNotifier {
  AuthModel _auth;
  UserModel _user;
  AuthModel get auth => _auth;
  UserModel get user => _user;

  void userInfo(AuthModel payload) {
    _auth = payload;
    notifyListeners();
  }

  void authInfo(UserModel payload) {
    _user = payload;
    notifyListeners();
  }
}
