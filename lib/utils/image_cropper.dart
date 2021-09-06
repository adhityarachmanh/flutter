import 'dart:io';
import 'package:app/config.dart';
import 'package:app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

Future<File?> imageCropper(File? imageFile, CropStyle cropStyle) async {
  if (imageFile == null) return imageFile;
  imageFile = await ImageCropper.cropImage(
      sourcePath: imageFile.path,
      cropStyle: cropStyle,
      aspectRatioPresets: Platform.isAndroid
          ? [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9
            ]
          : [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio5x3,
              CropAspectRatioPreset.ratio5x4,
              CropAspectRatioPreset.ratio7x5,
              CropAspectRatioPreset.ratio16x9
            ],
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: "${Config.application} Cropper",
          toolbarColor: Palette.colorPurple,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
      iosUiSettings: IOSUiSettings(
        title: "${Config.application} Cropper",
      ));
  return imageFile;
}
