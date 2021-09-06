/*
module  : IMAGEVIEWER WIDGET
creator : adhit
os      : msys
created : Fri, Sep  3, 2021  4:06:45 PM
*/

import 'dart:convert';

import 'package:app/constants/enum.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageViewerWidget extends StatefulWidget {
  final String uri;
  final String? name;
  final String? heroTag;
  final ImageViewerSource source;
  final Map<String, String>? httpHeaders;

  ImageViewerWidget({
    Key? key,
    required this.uri,
    this.name,
    this.heroTag,
    this.httpHeaders,
    this.source = ImageViewerSource.link,
  }) : super(key: key);

  @override
  _ImageViewerWidgetState createState() => _ImageViewerWidgetState();
}

class _ImageViewerWidgetState extends State<ImageViewerWidget>
    with TickerProviderStateMixin {
  bool downloadStatus = false;
  bool refreshStatus = false;
  late AnimationController _rotationController;
  double rotateStart = 0.0;

  @override
  void initState() {
    _rotationController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      extendBodyBehindAppBar: true,
      appBar: new AppBar(
        title: new Text(
          "${widget.name != null ? widget.name : ""}",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF000000).withOpacity(0.5),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () async {
                setState(() {
                  refreshStatus = true;
                });
                await Future.delayed(Duration(seconds: 1));
                setState(() {
                  refreshStatus = false;
                });
              }),
          IconButton(
              icon: Icon(Icons.rotate_90_degrees_ccw),
              onPressed: () {
                setState(() => rotateStart += 0.25);
              })
        ],
      ),
      body: refreshStatus == false
          ? Container(
              height: MediaQuery.of(context).size.height,
              color: Colors.black,
              child: RotationTransition(
                turns: Tween(begin: rotateStart, end: rotateStart + 0.25)
                    .animate(_rotationController),
                child: widget.source == ImageViewerSource.link
                    ? CachedNetworkImage(
                        httpHeaders: widget.httpHeaders,
                        imageUrl: widget.uri,
                        imageBuilder: (context, imageProvider) => PhotoView(
                          heroAttributes:
                              const PhotoViewHeroAttributes(tag: "imageViewer"),
                          imageProvider: imageProvider,
                        ),
                        placeholder: (context, url) => new Container(
                          height: 200,
                          color: Colors.black12,
                          child: new Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        errorWidget: (context, url, error) => new Icon(
                          Icons.image_not_supported,
                          size: 50,
                        ),
                      )
                    : Container(
                        width: MediaQuery.of(context).size.width,
                        child: PhotoView(
                          heroAttributes:
                              const PhotoViewHeroAttributes(tag: "imageViewer"),
                          imageProvider:
                              MemoryImage(Base64Decoder().convert(widget.uri)),
                        ),
                      ),
              ),
            )
          : new Container(
              color: Colors.black,
              child: new Center(
                child: new CircularProgressIndicator(),
              ),
            ),
    );
  }
}
