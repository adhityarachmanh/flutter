/*
module  : LABEL WIDGET
creator : adhit
os      : msys
created : Fri, Sep  3, 2021  3:09:42 PM
*/

import 'package:flutter/material.dart';
import 'package:app/config.dart';

class LabelWidget extends StatelessWidget {
  final String label;
  final String? fontFamily;
  final double fontSize;
  final TextAlign? textAlign;
  final Color? color;
  final FontWeight fontWeight;
  final FontStyle fontStyle;
  final TextOverflow textOverflow;
  final TextDecoration? decoration;
  final double? letterSpacing;
  final TextStyle? style;
  final int? maxLines;
  LabelWidget(
    this.label, {
    this.fontFamily,
    this.fontSize = 12.0,
    this.color = Colors.black38,
    this.fontWeight = FontWeight.bold,
    this.textAlign = TextAlign.center,
    this.textOverflow = TextOverflow.clip,
    this.fontStyle = FontStyle.normal,
    this.decoration,
    this.letterSpacing,
    this.style,
    this.maxLines,
  });
  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      textAlign: textAlign,
      overflow: textOverflow,
      maxLines: maxLines,
      style: style != null
          ? style
          : TextStyle(
              fontSize: fontSize,
              color: color,
              fontWeight: fontWeight,
              fontFamily:
                  (fontFamily != null ? fontFamily : Config.defaultFont),
              decoration: decoration,
              letterSpacing: letterSpacing,
              fontStyle: fontStyle,
            ),
    );
  }
}
