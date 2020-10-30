import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      // GLobal Provider
      ChangeNotifierProvider.value(value: RouteFunction()),
      ChangeNotifierProvider.value(value: IndexController())
    ],
    child: Main(),
  ));
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<IndexController>(context,listen: false).onInit();
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: primaryColor,
            pageTransitionsTheme: PageTransitionsTheme(builders: {
              TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
              TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
            })),
        navigatorKey: Provider.of<RouteFunction>(context).navigationKey,
        initialRoute: SplashScreen.routeName,
        routes: routes);
  }
}
