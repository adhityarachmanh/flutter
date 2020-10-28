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
      
      drawerEnableOpenDragGesture: true,
      drawer: Drawer(
        
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header',style: textSecondary,),
              decoration: BoxDecoration(
                color: Colors.red,
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
       
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
             
              },
            ),
          ],
        ),
      ),
      backgroundColor: primaryColor,
      appBar: AppBar(
     
        
        elevation: 0,
        title: Text(
          "Splash Screen",
          style: textPrimary,
        ),
      ),
      body: Container(
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "EX : Drawer ",
                style: textSecondary.copyWith(),
              ),
              RaisedButton(
                onPressed: () => {},
                child: Text("Drawer"),
              ),
              SizedBox(
                height: defaultMargin,
              ),
              Text(
                "EX : Navigate and save history route ",
                style: textSecondary.copyWith(),
              ),
              RaisedButton(
                onPressed: () => route.navigateTo(WelcomeScreen.routeName,
                    arguments: {"params": "From Splash Screen"}),
                child: Text("Navigate Now"),
              ),
              SizedBox(
                height: defaultMargin,
              ),
              // Text("EX : Navigate and remove history route ", style: textSecondary.copyWith(),),
              // RaisedButton(
              //   onPressed: () => route.navigateToAndRemoveUntil(
              //       WelcomeScreen.routeName,
              //       arguments: {"params": "From Splash Screen"}),
              //   child: Text("Navigate Now"),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
