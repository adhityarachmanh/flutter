part of '../app.dart';

class WelcomeScreen extends StatelessWidget {
  static final routeName = "/WelcomeScreen";
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
    final state = Provider.of<WelcomeController>(context);
    final dispatch = Provider.of<WelcomeController>(context, listen: false);
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: Text(
          "WelcomeScreen",
          style: textSecondary,
        ),
     
     
      ),
      body: Container(
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: defaultMargin,
              ),
              Text("Route Arguments key params : (${routeParams['params']})",style: textSecondary,),
              SizedBox(
                height: defaultMargin,
              ),
              Text("EX : Increment with local controller",style: textSecondary,),
              Text(
                state._increment.toString(),
                style:
                    textSecondary.copyWith(fontSize: 40,),
              ),
              Row(
                children: [
                  Spacer(),
                  RaisedButton(
                    onPressed: () => dispatch.setIncrement("+"),
                    child: Text("+"),
                  ),
                  SizedBox(
                    width: defaultMargin,
                  ),
                  RaisedButton(
                    onPressed: () => dispatch.setIncrement("-"),
                    child: Text("-"),
                  ),
                  Spacer()
                ],
              ),
              SizedBox(
                height: defaultMargin,
              ),
              Text("EX : Increment with global controller",style: textSecondary,),
              Text(
                globalState._increment.toString(),
                style:
                    textSecondary.copyWith(fontSize: 40),
              ),
              Row(
                children: [
                  Spacer(),
                  RaisedButton(
                    onPressed: () => globalDispatch.setIncrement("+"),
                    child: Text("+"),
                  ),
                  SizedBox(
                    width: defaultMargin,
                  ),
                  RaisedButton(
                    onPressed: () => globalDispatch.setIncrement("-"),
                    child: Text("-"),
                  ),
                  Spacer()
                ],
              ),
              RaisedButton(
                onPressed: () => route.navigateTo(
                  GlobalScreen.routeName,
                ),
                child: Text("Check Global Controller Different Page"),
              ),
              SizedBox(
                height: defaultMargin,
              ),
              RaisedButton(
                onPressed: () => route.navigateTo(
                  GlobalScreen.routeName,
                ),
                child: Text("Test API request"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
