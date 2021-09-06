import 'dart:convert';
import 'dart:io';
import 'package:app/utils/image_cropper.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

Future imagePicker(ImageSource source,
    {bool crop = false, bool base64 = false}) async {
  ImagePicker imagePicker = ImagePicker();
  final pickedFile = await imagePicker.pickImage(source: source);
  dynamic file = pickedFile != null ? File(pickedFile.path) : null;
  if (file == null) return file;
  if (crop) {
    file = await imageCropper(file, CropStyle.rectangle);
  }
  if (base64) {
    List<int> imageBytes = file.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);
    file = base64Image;
  }
  return file;
}
