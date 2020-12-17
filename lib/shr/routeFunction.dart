/*
module  : ROUTE SHR
creator : adhityarachmanh
os      : darwin19
created : Thu Dec 17 20:21:01 WIB 2020
product : ARH
version : v1.0
*/

part of '../app.dart';

class RouteFunction with ChangeNotifier {
  GlobalKey<NavigatorState> _navigationKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigationKey => _navigationKey;

  void pop() {
    return navigationKey.currentState.pop();
  }

  dynamic getParams(BuildContext context) {
    return ModalRoute.of(context).settings.arguments;
  }

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return _navigationKey.currentState
        .pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> navigateToReplacementNamed(String routeName,
      {dynamic arguments}) {
    return _navigationKey.currentState
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> navigateToAndRemoveUntil(String routeName,
      {dynamic arguments}) {
    return _navigationKey.currentState
        .pushNamedAndRemoveUntil(routeName, (r) => false, arguments: arguments);
  }
}
