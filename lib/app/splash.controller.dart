part of '../app.dart';

class SplashController with ChangeNotifier {
  

  void init(BuildContext context){
    Timer(new Duration(seconds: 3),()=>Provider.of<RouteFunction>(context,listen: false).navigateToAndRemoveUntil(LoginScreen.routeName));
  }
}
