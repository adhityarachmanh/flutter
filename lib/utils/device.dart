import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';

class DeviceInfoModel {
  late String deviceName;
  late String deviceVersion;
  late String identifier;

  DeviceInfoModel({
    required this.deviceName,
    required this.deviceVersion,
    required this.identifier,
  });

  // factory DeviceInfoModel.fromJson(Map<String, dynamic> json) {
  //   return DeviceInfoModel();
  // }

  Map<String, dynamic> toJson() {
    return {
      "deviceName": this.deviceName,
      "deviceVersion": this.deviceVersion,
      "identifier": this.identifier
    };
  }

  // DeviceInfoModel copyWith() => DeviceInfoModel();
}

class Device {
  static Future<DeviceInfoModel> getDeviceInfo() async {
    late String deviceName;
    late String deviceVersion;
    late String identifier;
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
        deviceName = androidInfo.model;
        AndroidBuildVersion androidVersion = androidInfo.version;
        deviceVersion = androidVersion.release;
        identifier = androidInfo.androidId;
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
        deviceName = iosInfo.name;
        deviceVersion = iosInfo.systemVersion;
        identifier = iosInfo.identifierForVendor;
      }
      return DeviceInfoModel(
          deviceName: deviceName,
          deviceVersion: deviceVersion,
          identifier: identifier);
    } on PlatformException {
      print("gagal mendaptkan info");
    }
    return DeviceInfoModel(deviceName: "", deviceVersion: "", identifier: "");
  }
}
