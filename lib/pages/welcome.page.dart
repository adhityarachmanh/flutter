/*
module  : WELCOME SCREEN
creator : Adhitya
os      : msys
created : Sat, Aug 14, 2021  7:49:17 PM
*/

import 'package:app/widgets/copyright.widget.dart';
import 'package:flutter/material.dart';
import 'package:app/widgets/label.widget.dart';

class WelcomePage extends StatefulWidget {
  static final routeName = "/WelcomePage";

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Center(
        child: LabelWidget("Welcome Screen!"),
      ),
      bottomNavigationBar: CopyrightWidget(),
    );
  }
}
