/*
module  : ROUTE
creator : adhityarachmanh
os      : darwin19
created : Thu Dec 17 20:21:01 WIB 2020
product : ARH
version : v1.0
*/
part of 'app.dart';
Map<String, Widget Function(BuildContext)> routes = {
	SplashScreen.routeName: (ctx) => ChangeNotifierProvider.value(value: SplashController(), child: SplashScreen()),
};
