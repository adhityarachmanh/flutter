/*
module  : NETWORKIMAGE WIDGET
creator : adhit
os      : msys
created : Thu, Sep  2, 2021  1:07:20 PM
*/

import 'package:app/services/server.service.dart';
import 'package:app/widgets/loadingindicator.widget.dart';
import 'package:flutter/material.dart';

class NetworkImageWidget extends StatelessWidget {
  final String? imageURL;
  final Function() onReload;
  final Widget? placeholder;

  NetworkImageWidget({
    required this.imageURL,
    required this.onReload,
    this.placeholder,
  });
  @override
  Widget build(BuildContext context) {
    if (imageURL == null)
      return placeholder != null
          ? placeholder!
          : Icon(Icons.image_not_supported, size: 50);
    return FutureBuilder(
      future: ServerService.getImage(imageURL!),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return LoadingIndicatorWidget();
          default:
            if (snapshot.hasData) {
              return Image.memory(
                snapshot.data,
                fit: BoxFit.cover,
              );
            }
            return GestureDetector(
              onTap: onReload,
              child: Icon(
                Icons.refresh,
                size: 50,
              ),
            );
        }
      },
    );
  }
}
