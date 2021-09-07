import 'package:app/constants/colors.dart';
import 'package:app/widgets/copyright.widget.dart';
import 'package:app/widgets/label.widget.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  static final routeName = "/WelcomeScreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.colorWhite,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        brightness: Brightness.dark,
        elevation: 0.0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LabelWidget(
              "Welcome Screen!",
              fontSize: 18,
            ),
            LabelWidget("Welcome Screen!")
          ],
        ),
      ),
      bottomNavigationBar: CopyrightWidget(),
    );
  }
}
