/*
module  : BUTTON WIDGET
creator : Adhitya
os      : msys
created : Tue, Aug  3, 2021 10:11:50 AM
*/

import 'package:flutter/material.dart';
import 'package:app/widgets/label.widget.dart';

class ButtonWidget extends StatelessWidget {
  final Function() onPressed;
  final String label;
  final TextStyle? textStyle;
  final double fontSize;
  final Color? borderColor;
  final Color backgroundColor;
  final Color? fontColor;
  final double borderRadius;
  final double width;
  final double height;
  final Widget? child;

  ButtonWidget(
    this.label, {
    required this.onPressed,
    this.textStyle,
    this.fontSize = 16.0,
    this.borderColor,
    this.fontColor,
    this.backgroundColor = Colors.transparent,
    this.borderRadius = 5.0,
    this.width = 120.0,
    this.height = 50.0,
    this.child,
  });
  @override
  Widget build(BuildContext context) {
    return new OutlinedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all<Size>(Size(width, height)),
        backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
        side: MaterialStateProperty.all<BorderSide>(
          BorderSide(
            width: 1,
            style: BorderStyle.solid,
            color: (borderColor != null
                ? borderColor
                : Theme.of(context).primaryColor) as Color,
          ),
        ),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
      ),
      child: child != null
          ? child as Widget
          : LabelWidget(
              label,
              style: textStyle != null
                  ? textStyle
                  : TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: fontSize,
                      color: (fontColor != null
                          ? fontColor
                          : Theme.of(context).primaryColor),
                    ),
            ),
    );
  }
}
