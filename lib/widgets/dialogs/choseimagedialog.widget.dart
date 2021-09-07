/*
module  : CHOSEIMAGEDIALOG WIDGET
creator : adhityarachmanh
os      : darwin20
created : Tue Mar  9 17:36:06 WIB 2021
*/

import 'package:app/constants/colors.dart';
import 'package:app/utils/image_picker.dart';
import 'package:app/widgets/label.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ChoseImageDialogWidget extends StatelessWidget {
  final TextStyle textStyle;
  final bool base64;
  ChoseImageDialogWidget(
      {this.textStyle = const TextStyle(), this.base64 = false});

  @override
  Widget build(BuildContext context) {
    return PlatformAlertDialog(
      title: LabelWidget(
        "Pilih Gambar",
        style: textStyle,
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            // ButtonRoundedWidget(label: "test",onPressed: ()=>onImageChange('test'),)
            TextButton(
              onPressed: () async => Get.back(
                result: await imagePicker(ImageSource.camera, base64: base64),
              ),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 26,
                    height: 26,
                    child: Stack(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: new BorderRadius.circular(40),
                            color: Palette.colorPurple,
                          ),
                        ),
                        Center(
                          child: Icon(
                            Icons.camera,
                            color: Theme.of(context).scaffoldBackgroundColor,
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  LabelWidget(
                    "Buka Kamera",
                    style: textStyle,
                  ),
                  Spacer(),
                ],
              ),
            ),
            TextButton(
              onPressed: () async => Get.back(
                result: await imagePicker(
                  ImageSource.gallery,
                  base64: base64,
                ),
              ),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 26,
                    height: 26,
                    child: Stack(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: new BorderRadius.circular(40),
                              color: Palette.colorPurple),
                        ),
                        Center(
                          child: Icon(
                            Icons.photo_library,
                            color: Theme.of(context).scaffoldBackgroundColor,
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  LabelWidget(
                    "Buka Galeri",
                    style: textStyle,
                  ),
                  Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
