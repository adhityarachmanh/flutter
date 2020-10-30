part of '../app.dart';

class SplashController with ChangeNotifier {
    final String title = "SplashControllerWorks!";

    void onInit() {
        print("init SplashController");
    } 
    void onDestroy() {
        print("destroy SplashController");
    }
}
