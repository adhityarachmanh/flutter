/*
module  : TEXTFIELD WIDGET
creator : Adhitya
os      : msys
created : Tue, Aug  3, 2021 11:24:20 AM
*/

import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? label;
  final Color? labelColor;
  final String? hintText;
  final String? errorText;
  final int? maxLine;
  final TextInputType? textInputType;
  final double? fontSize;
  final Function(String)? onChanged;
  final int? maxLength;
  final FontWeight? fontWeight;
  final TextAlign textAlign;
  final GestureTapCallback? onTap;
  final bool readOnly;
  final Color? fillColor;
  final InputBorder? border;
  final bool obscureText;
  final TextCapitalization textCapitalization;
  TextFieldWidget({
    required this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.border,
    this.fillColor,
    this.errorText,
    this.fontSize,
    this.fontWeight,
    this.hintText,
    this.label,
    this.labelColor,
    this.maxLength,
    this.maxLine,
    this.obscureText = false,
    this.onChanged,
    this.onTap,
    this.readOnly = false,
    this.textAlign = TextAlign.left,
    this.textCapitalization = TextCapitalization.none,
    this.textInputType,
  });
  @override
  Widget build(BuildContext context) {
    return new Theme(
      data: new ThemeData(primaryColor: Colors.black12),
      child: new TextField(
        controller: controller,
        textAlign: textAlign,
        readOnly: readOnly,
        decoration: new InputDecoration(
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            labelText: label,
            hintText: hintText,
            filled: fillColor != null ? true : false,
            fillColor: fillColor,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            enabledBorder: border != null ? border : InputBorder.none,
            border: border != null ? border : InputBorder.none,
            focusedBorder: border != null ? border : InputBorder.none,
            hintStyle: TextStyle(
                fontSize: (fontSize != null ? fontSize : 14.0),
                fontWeight: fontWeight,
                color: Colors.black26),
            labelStyle: TextStyle(
                fontSize: (fontSize != null ? fontSize : 14.0),
                fontWeight: fontWeight,
                color: labelColor != null ? labelColor : Colors.black26),
            contentPadding: EdgeInsets.all(10),
            isDense: true),
        keyboardType: textInputType,
        textCapitalization: textCapitalization,
        style: new TextStyle(
          fontSize: (fontSize != null ? fontSize : 14.0),
          fontWeight: fontWeight,
        ),
        maxLines: maxLine != null ? maxLine : 1,
        obscureText: obscureText,
        onChanged: onChanged,
        onTap: onTap,
      ),
    );
  }
}
