part of 'app.dart';
Map<String, Widget Function(BuildContext)> routes = {
  SplashScreen.routeName: (ctx) =>ChangeNotifierProvider.value(value: SplashController(), child: SplashScreen()),
	WelcomeScreen.routeName: (ctx) => ChangeNotifierProvider.value(value: WelcomeController(), child: WelcomeScreen()),
	GlobalScreen.routeName: (ctx) => ChangeNotifierProvider.value(value: GlobalController(), child: GlobalScreen()),
};