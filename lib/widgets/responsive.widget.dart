/*
module  : RESPONSIVE WIDGET
creator : arh
os      : linux-gnu
created : Rab Jan 13 11:14:42 WIB 2021
*/

import 'package:flutter/material.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget? mobile;
  final Widget? tablet;
  final Widget? desktop;

  const ResponsiveWidget({
    required Key key,
    this.mobile,
    this.tablet,
    this.desktop,
  }) : super(key: key);

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 800;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 800 &&
      MediaQuery.of(context).size.width < 1200;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1200;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1200) {
          return desktop!;
        } else if (constraints.maxWidth >= 800) {
          return tablet ?? mobile!;
        } else {
          return mobile!;
        }
      },
    );
  }
}
