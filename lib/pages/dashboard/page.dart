/*
module  : Dashboard SCREEN
creator : Adhitya
os      : msys
created : Sat, Aug 14, 2021  7:49:17 PM
*/

import 'package:app/pages/dashboard/controller.dart';
import 'package:app/widgets/copyright.widget.dart';
import 'package:flutter/material.dart';
import 'package:app/widgets/label.widget.dart';
import 'package:get/get.dart';

class DashboardPage extends StatefulWidget {
  static final routeName = "/DashboardPage";

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DashboardController>();
    return Scaffold(
      // appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LabelWidget(
              "Dashboard Screen!",
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
