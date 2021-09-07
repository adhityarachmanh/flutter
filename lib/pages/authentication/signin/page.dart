/*
module  : SIGNIN SCREEN
creator : adhityarachmanh
os      : darwin20
created : Sun May  9 15:32:17 WIB 2021
*/

import 'package:app/pages/authentication/signin/controller.dart';
import 'package:flutter/material.dart';
import 'package:app/widgets/copyright.widget.dart';
import 'package:app/widgets/label.widget.dart';
import 'package:get/get.dart';

class SigninPage extends GetView<SignInController> {
  static final routeName = "/SigninPage";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LabelWidget(
              "Welcome Screen!",
              fontSize: 18,
            ),
            LabelWidget(controller.title)
          ],
        ),
      ),
      bottomNavigationBar: CopyrightWidget(),
    );
  }
}
