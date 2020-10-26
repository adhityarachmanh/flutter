part of '../app.dart';

class ResponseAPI {
  int s;
  String msg;
  dynamic data;
  ResponseAPI({@required this.s, this.msg, this.data});
  factory ResponseAPI.fromJson(Map<String, dynamic> json) {
    return ResponseAPI(s: json['s'], msg: json['msg'], data: json['data']);
  }
}