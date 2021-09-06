/*
module  : ROUNDEDIMAGE WIDGET
creator : adhit
os      : msys
created : Fri, Sep  3, 2021  3:58:13 PM
*/

import 'dart:convert';

import 'package:app/constants/enum.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class RoundedImageWidget extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Map<String, String>? httpHeaders;
  final RoundedImageType type;
  RoundedImageWidget(
    this.url, {
    this.width,
    this.height,
    this.backgroundColor,
    this.httpHeaders,
    this.type = RoundedImageType.link,
  });
  @override
  Widget build(BuildContext context) {
    return new CircleAvatar(
      backgroundColor: backgroundColor,
      child: ClipOval(
        child: (type == RoundedImageType.link
            ? CachedNetworkImage(
                httpHeaders: httpHeaders,
                imageUrl: url,
                imageBuilder: (context, imageProvider) => Container(
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: null,
                errorWidget: (context, url, error) => new CircleAvatar(
                  backgroundColor: Colors.white,
                  child: new Image.asset("assets/images/default.png"),
                ),
              )
            : new Image.memory(
                Base64Decoder().convert(url),
                height: 38,
                width: 38,
              )),
      ),
    );
  }
}
