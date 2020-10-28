part of '../app.dart';

class WelcomeScreen extends StatelessWidget {
  static final routeName = "/WelcomeScreen";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final route = Provider.of<RouteFunction>(context, listen: false);
    final routeParams = route.getParams(context);
    final state = Provider.of<WelcomeController>(context);
    final dispatch = Provider.of<WelcomeController>(context, listen: false);
    return Scaffold(
      body: Container(
        child: Center(
          child: Text("WelcomeScreen"),
        ),
      ),
    );
  }
}
