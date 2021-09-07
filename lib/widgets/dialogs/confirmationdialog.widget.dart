/*
module  : CONFIRMATIONDIALOG WIDGET
creator : adhityarachmanh
os      : darwin20
created : Thu Mar 18 19:24:34 WIB 2021
*/

import 'package:app/widgets/label.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:get/get.dart';

class ConfirmationDialogWidget extends StatelessWidget {
  final String title;
  final String message;
  final String confirmTextButton;
  final String cancelTextButton;
  final TextStyle textStyle;
  ConfirmationDialogWidget({
    required this.title,
    required this.message,
    this.confirmTextButton = "Yes",
    this.cancelTextButton = "No",
    this.textStyle = const TextStyle(),
  });
  @override
  Widget build(BuildContext context) {
    return PlatformAlertDialog(
      title: LabelWidget(
        title,
        style: textStyle,
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            LabelWidget(
              message,
              style: textStyle,
            )
          ],
        ),
      ),
      actions: <Widget>[
        PlatformDialogAction(
          child: LabelWidget(
            confirmTextButton,
            style: textStyle,
          ),
          onPressed: () => Get.back(
            result: true,
          ),
        ),
        PlatformDialogAction(
          child: LabelWidget(
            cancelTextButton,
            style: textStyle,
          ),
          onPressed: () => Get.back(
            result: false,
          ),
        ),
      ],
    );
  }
}
