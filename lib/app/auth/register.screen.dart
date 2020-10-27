part of '../../app.dart';

class RegisterScreen extends StatelessWidget {
  static final routeName = "/RegisterScreen";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final state = Provider.of<RegisterController>(context);
    final controller = Provider.of<RegisterController>(context, listen: false);
    final route = Provider.of<RouteFunction>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: secondaryColor,
          title: Text(
            "Sign Up",
            style: textFontFS.copyWith(
                color: primaryColor, fontWeight: FontWeight.w600),
          ),
          leading: GestureDetector(
            onTap: route.pop,
            child: Icon(
              Icons.arrow_back,
              color: primaryColor,
            ),
          ),
        ),
        body: Stack(
          children: [
            SafeArea(
              child: Container(color: secondaryColor),
            ),
            ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Center(
                        child: GestureDetector(
                            onTap: () => route.pop(),
                            child: Text("RegisterScreen")),
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
