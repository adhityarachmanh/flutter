/*
module  : SPLASH SCREEN
creator : adhityarachmanh
os      : darwin19
created : Thu Dec 17 20:21:01 WIB 2020
product : ARH
version : v1.0
*/

part of '../app.dart';

class SplashScreen extends StatefulWidget {
  static final routeName = "/SplashScreen";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final TrackingScrollController _trackingScrollController = TrackingScrollController();

  @override
  void dispose() {
    _trackingScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        SafeAreaWidget(
          safearea: Palette.primaryColor,
          background: Palette.lightColor,
        ),
        ResponsiveWidget(
          mobile:_SplashScreenMobile(scrollController: _trackingScrollController),
          tablet:_SplashScreenTablet(scrollController: _trackingScrollController),
          desktop:_SplashScreenDesktop(scrollController: _trackingScrollController),
        ),
      ],
    ));
  }
}

class _SplashScreenMobile extends StatelessWidget {
  final TrackingScrollController scrollController;

  const _SplashScreenMobile({Key key, @required this.scrollController})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // Global controller
    final globalState = Provider.of<IndexController>(context);
    final globalDispatch = Provider.of<IndexController>(context, listen: false);
    // Route
    final route = Provider.of<RouteFunction>(context, listen: false);
    final routeParams = route.getParams(context);
    // Websocket
    final websocket = Provider.of<WebsocketFunction>(context, listen: false);
    // Local controller
    final state = Provider.of<SplashController>(context);
    final dispatch = Provider.of<SplashController>(context, listen: false);
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            height: SizeConfig.screenHeight,
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("SplashMobileScreen!",style: MyText.primary(font: MyFont.montserrat).copyWith(fontSize: 25)),
                SizedBox(height: defaultMargin),
                Text(state.title, style: MyText.primary(font: MyFont.montserrat).copyWith(fontSize: 25)),
              ],
            )),
          ),
        )
      ],
    );
  }
}

class _SplashScreenTablet extends StatelessWidget {
  final TrackingScrollController scrollController;

  const _SplashScreenTablet({Key key, @required this.scrollController})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // Global controller
    final globalState = Provider.of<IndexController>(context);
    final globalDispatch = Provider.of<IndexController>(context, listen: false);
    // Route
    final route = Provider.of<RouteFunction>(context, listen: false);
    final routeParams = route.getParams(context);
    // Websocket
    final websocket = Provider.of<WebsocketFunction>(context, listen: false);
    // Local controller
    final state = Provider.of<SplashController>(context);
    final dispatch = Provider.of<SplashController>(context, listen: false);
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            height: SizeConfig.screenHeight,
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("SplashMobileScreen!",style: MyText.primary(font: MyFont.montserrat).copyWith(fontSize: 25)),
                SizedBox(height: defaultMargin),
                Text(state.title, style: MyText.primary(font: MyFont.montserrat).copyWith(fontSize: 25)),
              ],
            )),
          ),
        )
      ],
    );
  }
}

class _SplashScreenDesktop extends StatelessWidget {
  final TrackingScrollController scrollController;

  const _SplashScreenDesktop({Key key, @required this.scrollController})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // Global controller
    final globalState = Provider.of<IndexController>(context);
    final globalDispatch = Provider.of<IndexController>(context, listen: false);
    // Route
    final route = Provider.of<RouteFunction>(context, listen: false);
    final routeParams = route.getParams(context);
    // Websocket
    final websocket = Provider.of<WebsocketFunction>(context, listen: false);
    // Local controller
    final state = Provider.of<SplashController>(context);
    final dispatch = Provider.of<SplashController>(context, listen: false);
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            height: SizeConfig.screenHeight,
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("SplashMobileScreen!",style: MyText.primary(font: MyFont.montserrat).copyWith(fontSize: 25)),
                SizedBox(height: defaultMargin),
                Text(state.title, style: MyText.primary(font: MyFont.montserrat).copyWith(fontSize: 25)),
              ],
            )),
          ),
        )
      ],
    );
  }
}