/*
module  : CARDHORIZONTAL WIDGET
creator : adhityarachmanh
os      : darwin20
created : Fri May 14 14:13:22 WIB 2021
product : _PRODUCT_
version : _VERSION_
*/

import 'package:app/constants/colors.dart';
import 'package:app/widgets/label.widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CardHorizontalWidget extends StatelessWidget {
  CardHorizontalWidget({
    this.title = "Placeholder Title",
    this.cta = "",
    this.img = "https://via.placeholder.com/200",
    this.tap = defaultFunc,
  });

  final String cta;
  final String img;
  final Function() tap;
  final String title;

  static void defaultFunc() {
    print("the function works!");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      child: GestureDetector(
        onTap: tap,
        child: Card(
          elevation: 0.6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(6.0),
            ),
          ),
          child: Row(
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(6.0),
                      bottomLeft: Radius.circular(6.0),
                    ),
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        img,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LabelWidget(
                        title,
                        maxLines: 1,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 13,
                        ),
                      ),
                      LabelWidget(
                        cta,
                        maxLines: 4,
                        style: TextStyle(
                          color: Palette.colorPurple,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
