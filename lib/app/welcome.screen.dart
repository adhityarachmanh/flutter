part of '../app.dart';

class WelcomeScreen extends StatelessWidget {
  static final routeName = "/welcome";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text("Hello Brow"),
        ),
      ),
    );
  }
}
