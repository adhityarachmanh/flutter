part of '../app.dart';

class SplashScreen extends StatelessWidget {
  static final routeName = "/";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final route = Provider.of<RouteFunction>(context, listen: false);
    final routeParams = route.getParams(context);
    final state = Provider.of<SplashController>(context);
    final dispatch = Provider.of<SplashController>(context, listen: false);
    dispatch.init(context);
    return Scaffold(
        backgroundColor: primaryColor.withAlpha(75),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Container(
              width: SizeConfig.screenWidth / 1.5,
              height: SizeConfig.screenHeight / 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/note.png"),
                  Text(
                    "Musical",
                    style:
                        textFontFS.copyWith(fontSize: 30, letterSpacing: 10),
                  ),
                  SizedBox(
                    height: defaultMargin,
                  ),
                  SpinKitWave(
                    color: Colors.white,
                    size: defaultMargin / 1.5,
                  ),
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal:defaultMargin/1.5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(config.creator,style: textFontFS.copyWith(fontWeight: FontWeight.bold,letterSpacing: defaultMargin/4))
                  ],
              ),
            ),
            SizedBox(height: defaultMargin/1.5,)
          ],
        ));
  }
}
