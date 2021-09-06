/*
module  : DASHBOARD SCREEN
creator : adhityarachmanh
os      : darwin20
created : Sun May  9 15:32:15 WIB 2021
*/

import 'package:flutter/material.dart';
import 'package:app/widgets/label.widget.dart';

class DashboardPage extends StatefulWidget {
  static final routeName = "/DashboardPage";

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: LabelWidget(
        "Dashboard Screen!",
        fontSize: 18,
      ),
    ));
  }
}
