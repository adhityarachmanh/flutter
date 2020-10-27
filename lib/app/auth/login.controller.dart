part of '../../app.dart';

class LoginController with ChangeNotifier {
  TextEditingController _emailController = TextEditingController(text: "");
  TextEditingController _paswordController = TextEditingController(text: "");
  bool _showPassword = false;

  void showPassword() {
    print("object");
    _showPassword = !_showPassword;
    notifyListeners();
  }

  void setEmailController(text) {
    _emailController.text = text;
    notifyListeners();
  }

  void setPasswordController(text) {
    _paswordController.text = text;
    notifyListeners();
  }

  void login() {}
}
