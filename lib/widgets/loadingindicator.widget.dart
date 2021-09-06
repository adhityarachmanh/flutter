/*
module  : LOADINGINDICATOR WIDGET
creator : Lucifer
os      : msys
created : Sat, Aug 28, 2021  5:15:40 PM
*/

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingIndicatorWidget extends StatelessWidget {
  LoadingIndicatorWidget();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Platform.isAndroid
          ? CircularProgressIndicator()
          : CupertinoActivityIndicator(),
    );
  }
}
