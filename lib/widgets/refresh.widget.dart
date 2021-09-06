/*
module  : REFRESH WIDGET
creator : adhit
os      : msys
created : Fri, Sep  3, 2021  3:05:46 PM
*/

import 'package:app/widgets/label.widget.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RefreshWidget extends StatelessWidget {
  final RefreshController controller;
  final Function() onRefresh;
  final Function()? onLoading;
  final Widget child;
  final Widget? header;
  RefreshWidget({
    required this.controller,
    required this.onRefresh,
    required this.child,
    this.onLoading,
    this.header,
  });
  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: controller,
      enablePullDown: true,
      enablePullUp: onLoading != null ? true : false,
      enableTwoLevel: true,
      header: header,
      child: child,
      footer: CustomFooter(builder: (BuildContext context, LoadStatus? mode) {
        Widget body;
        if (mode == LoadStatus.idle) {
          body = LabelWidget(
            "Tarik untuk memuat lebih banyak",
            fontSize: 14.0,
            color: Colors.black54,
            textAlign: TextAlign.left,
            fontWeight: FontWeight.w400,
          );
        } else if (mode == LoadStatus.failed) {
          body = LabelWidget(
            "Gagal memuat, tarik untuk mengulang",
            fontSize: 14.0,
            color: Colors.black54,
            textAlign: TextAlign.left,
            fontWeight: FontWeight.w400,
          );
        } else if (mode == LoadStatus.loading) {
          body = RefreshProgressIndicator();
        } else if (mode == LoadStatus.canLoading) {
          body = LabelWidget(
            "Lepaskan untuk memuat lebih banyak",
            fontSize: 14.0,
            color: Colors.black54,
            textAlign: TextAlign.left,
            fontWeight: FontWeight.w400,
          );
        } else {
          body = LabelWidget(
            "Tarik untuk memuat lebih banyak",
            fontSize: 14.0,
            color: Colors.black54,
            textAlign: TextAlign.left,
            fontWeight: FontWeight.w400,
          );
        }
        return Container(
          height: 55.0,
          child: Center(child: body),
        );
      }),
    );
  }
}
