/*
module  : SAFEAREA WIDGET
creator : adhityarachmanh
os      : darwin19
created : Sun Jan  3 20:32:12 WIB 2021
product : ARH
version : v1.0
*/

part of '../app.dart';

class SafeAreaWidget extends StatelessWidget {
  final Color background;
  final Color safearea;
  SafeAreaWidget({this.background, this.safearea});
  @override
  Widget build(BuildContext context) {
    final Color colors = Platform.isIOS ? background : safearea;
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(color: colors),
        ),
        SafeArea(
          child: Container(
            color: background,
          ),
        ),
      ],
    );
  }
}
