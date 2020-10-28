part of 'app.dart';

class IndexController with ChangeNotifier {
  int _increment = 0;

  void setIncrement(type) {
    switch (type) {
      case "+":
        plusIncrement();
        break;
      default:
        minIncrement();
    }
  }

  void plusIncrement() {
    _increment += 1;
    notifyListeners();
  }

  void minIncrement() {
    _increment -= 1;
    if (_increment < 0) {
      _increment=0;
    }
    notifyListeners();
  }
  
}
