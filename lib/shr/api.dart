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

class Rest {
  static String contentType = "Content-Type";
  static String appJSON = "application/json";
  static String multipartFormData = "multipart/form-data";
  static String xToken = 'XA';
  static String serviceBase = config.res;
  static String api = config.api;
  static String routeAPI(String routeName) {
    return "$api/$serviceBase/$routeName";
  }

  Future get(String routeName, {Map<String, dynamic> headers}) async {
    var response = await http.get(routeAPI(routeName), headers: headers);
    if (response.statusCode == 200) return response;
  }

  Future put(String routeName,
      {Map<String, dynamic> data, Map<String, dynamic> headers}) async {
    var response = await http.post(routeAPI(routeName),
        headers: headers, body: jsonEncode(data));

    if (response.statusCode == 200) return response;
  }

  Future upload(String routeName, File file,
      {Map<String, dynamic> headers}) async {
    var request = http.MultipartRequest('POST', Uri.parse(routeAPI(routeName)));
    request.files.add(http.MultipartFile(
        'file', file.readAsBytes().asStream(), file.lengthSync(),
        filename: basename(file.path).split("/").last));
    var response = await request.send();
    if (response.statusCode == 200) return response;
  }

  Future fUpload(String routeName, File file,
      {Map<String, dynamic> data, Map<String, dynamic> headers}) async {
    var request = http.MultipartRequest('POST', Uri.parse(routeAPI(routeName)));
    data.forEach((key, value) {
      request.fields[key] = value;
    });
    request.files.add(http.MultipartFile(
        'file', file.readAsBytes().asStream(), file.lengthSync(),
        filename: basename(file.path).split("/").last));
    var response = await request.send();
    if (response.statusCode == 200) return response;
  }
}

final rest = new Rest();
