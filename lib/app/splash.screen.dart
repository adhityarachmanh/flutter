part of '../app.dart';

class SplashScreen extends StatelessWidget {
  static final routeName = "/SplashScreen";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // Global controller
    final globalState = Provider.of<IndexController>(context);
    final globalDispatch = Provider.of<IndexController>(context, listen: false);
    // Route
    final route = Provider.of<RouteFunction>(context, listen: false);
    final routeParams = route.getParams(context);
    // Local controller
    final state = Provider.of<SplashController>(context);
    final dispatch = Provider.of<SplashController>(context, listen: false);
    return Scaffold(
      body: Container(
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight,
        child: Center(
          child: Text(
            "SplashScreen",
          ),
        ),
      ),
    );
  }
}
