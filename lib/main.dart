/*
module  : MAIN
creator : adhityarachmanh
os      : darwin19
created : Thu Dec 17 20:21:01 WIB 2020
product : ARH
version : v1.0
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      // GLobal Provider
      ChangeNotifierProvider.value(value: RouteFunction()),
      ChangeNotifierProvider.value(value: WebsocketFunction()),
      ChangeNotifierProvider.value(value: IndexController()),
    ],
    child: Main(),
  ));
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<IndexController>(context,listen: false).onInit(context);
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
