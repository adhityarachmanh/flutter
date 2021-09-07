/*
module  : WELCOME SCREEN
creator : Adhitya
os      : msys
created : Sat, Aug 14, 2021  7:49:17 PM
*/

import 'package:app/pages/welcome/controller.dart';
import 'package:app/widgets/copyright.widget.dart';
import 'package:flutter/material.dart';
import 'package:app/widgets/label.widget.dart';
import 'package:get/get.dart';

class WelcomePage extends GetView<WelcomeController> {
  static final routeName = "/WelcomePage";
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
