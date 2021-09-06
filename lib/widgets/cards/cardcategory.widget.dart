/*
module  : CARDCATEGORY WIDGET
creator : adhityarachmanh
os      : darwin20
created : Fri May 14 14:11:29 WIB 2021
product : _PRODUCT_
version : _VERSION_
*/

import 'package:app/widgets/label.widget.dart';
import 'package:flutter/material.dart';

class CardCategoryWidget extends StatelessWidget {
  CardCategoryWidget({
    this.title = "Placeholder Title",
    this.img = "https://via.placeholder.com/250",
    this.tap = defaultFunc,
  });

  final String img;
  final Function() tap;
  final String title;

  static void defaultFunc() {
    print("the function works!");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 252,
        width: null,
        child: GestureDetector(
          onTap: tap,
          child: Card(
              elevation: 0.4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6.0))),
              child: Stack(children: [
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(6.0)),
                        image: DecorationImage(
                          image: NetworkImage(img),
                          fit: BoxFit.cover,
                        ))),
                Container(
                    decoration: BoxDecoration(
                        color: Colors.black45,
                        borderRadius: BorderRadius.all(Radius.circular(6.0)))),
                Center(
                  child: LabelWidget(title,
                      style: TextStyle(
                          color: Theme.of(context).primaryColorLight,
                          fontWeight: FontWeight.w600,
                          fontSize: 18.0)),
                )
              ])),
        ));
  }
}
