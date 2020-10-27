import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: RouteFunction()),
      ChangeNotifierProvider.value(value: IndexController())
    ],
    child: Main(),
  ));
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: Provider.of<RouteFunction>(context).navigationKey,
        initialRoute: SplashScreen.routeName,
        routes: routes);
  }
}
