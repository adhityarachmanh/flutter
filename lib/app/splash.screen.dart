part of '../app.dart';

class SplashScreen extends StatelessWidget {
    static final routeName = "/";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor.fromHex("#ea5252"),
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                Colors.blue[500],
                Colors.blue[800],
              ],
                  stops: [
                0.4,
                0.9
              ])),
          child: Center(
              child: GestureDetector(
                onTap: (){
                  Provider.of<RouteFunction>(context,listen: false).navigateToAndRemoveUntil(WelcomeScreen.routeName);
                },
                              child: Text(
            "Loading",
            maxLines: 1,
            style:
                  textFontFS.copyWith(fontWeight: FontWeight.bold, fontSize: 30),
          ),
              ))),
    );
  }
}
