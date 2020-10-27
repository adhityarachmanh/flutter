part of 'app.dart';

Map<String, Widget Function(BuildContext)> routes = {
  SplashScreen.routeName: (ctx) =>ChangeNotifierProvider.value(value: SplashController(), child: SplashScreen()),
	LoginScreen.routeName: (ctx) => ChangeNotifierProvider.value(value: LoginController(), child: LoginScreen()),
	RegisterScreen.routeName: (ctx) => ChangeNotifierProvider.value(value: RegisterController(), child: RegisterScreen()),
};