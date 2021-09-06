/*
module  : SIGNIN SCREEN
creator : adhityarachmanh
os      : darwin20
created : Sun May  9 15:32:17 WIB 2021
*/

import 'package:flutter/material.dart';
import 'package:app/widgets/copyright.widget.dart';
import 'package:app/widgets/label.widget.dart';

class SigninPage extends StatefulWidget {
  static final routeName = "/SigninPage";

  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Center(
        child: LabelWidget("Sign In SCreen!"),
      ),
      bottomNavigationBar: CopyrightWidget(),
    );
  }
}
