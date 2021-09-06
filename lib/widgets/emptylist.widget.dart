/*
module  : EMPTYLIST WIDGET
creator : adhityarachmanh
os      : darwin20
created : Wed Mar 17 18:06:14 WIB 2021
*/

import 'package:app/constants/style.dart';
import 'package:app/utils/size_config..dart';
import 'package:app/widgets/label.widget.dart';
import 'package:flutter/material.dart';

class EmptyListWidget extends StatelessWidget {
  final String text;
  final Color color;
  final IconData icon;
  EmptyListWidget(
      {required this.text, required this.color, required this.icon});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      height: SizeConfig.screenHeight / 1.5,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(icon, size: 100, color: color),
            SizedBox(
              height: defaultMargin * 0.5,
            ),
            LabelWidget(
              text,
              fontSize: 20,
              fontWeight: FontWeight.w300,
              color: color,
            ),
          ],
        ),
      ),
    );
  }
}
