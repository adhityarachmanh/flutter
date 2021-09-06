/*
module  : COPYRIGHT WIDGET
creator : Ananda
os      : msys
created : Fri, Aug 27, 2021  9:38:30 AM
*/

import 'package:app/config.dart';
import 'package:flutter/material.dart';
import 'package:app/widgets/label.widget.dart';

class CopyrightWidget extends StatelessWidget {
  CopyrightWidget();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: LabelWidget(
        "Copyright ©  ${Config.copyright}  ${Config.application}, All rights reserved.",
        fontSize: 10,
      ),
    );
  }
}
