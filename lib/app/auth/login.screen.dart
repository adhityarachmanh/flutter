part of '../../app.dart';

class LoginScreen extends StatelessWidget {
  static final routeName = "/LoginScreen";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final route = Provider.of<RouteFunction>(context, listen: false);
    final routeParams = route.getParams(context);
    final state = Provider.of<LoginController>(context);
    final dispatch = Provider.of<LoginController>(context, listen: false);
    return Scaffold(
      body: Container(
        child: Center(
          child: Text("LoginScreen"),
        ),
      ),
    );
  }
}
