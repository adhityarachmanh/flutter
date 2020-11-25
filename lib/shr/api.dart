part of '../app.dart';

class ResponseAPI {
  int s;
  String msg;
  dynamic data;
  String creator;
  ResponseAPI({@required this.s, this.msg, this.data, this.creator});
  factory ResponseAPI.fromJson(Map<String, dynamic> json) {
    return ResponseAPI(
      s: json['s'],
      msg: json['msg'],
      data: rest.decryptData(json['data']),
      creator: json['creator'],
    );
  }
}

class Rest {
  static String contentType = "Content-Type";
  static String appJSON = "application/json";
  static String multipartFormData = "multipart/form-data";
  static String authTokenKey = 'Authorization';
  static String xToken = 'XA';
  static String serviceBase = config.res;
  static String api = config.api;
  static String routeAPI(String routeName) {
    return "$api/$serviceBase/$routeName";
  }

  static dynamic encryptData(data) {
    Map<String, dynamic> newData = {
      "creator": config.creatorName,
      "data": null,
    };
    if (config.production) {
      newData['data'] = global.enc(jsonEncode(data), 2, 6);
    } else {
      newData['data'] = data;
    }
    return jsonEncode(newData);
  }

  static createHeaders(_headers, {bool middleware = false}) {
    var token = global.getToken();
    if (token != null && middleware) {
      _headers[authTokenKey] = token;
    }
    return {
      "headers": _headers,
    };
  }

  dynamic decryptData(ResponseAPI response) {
    if (config.production && response.data != null) {
      response.data = jsonDecode(global.dec(response.data, 2, 6));
    }
    return response;
  }

  Future get(String routeName, {Map<String, dynamic> headers}) async {
    var response = await http.get(routeAPI(routeName), headers: headers);
    if (response.statusCode == 200) return response;
  }

  Future put(String routeName,
      {Map<String, dynamic> data, Map<String, dynamic> headers}) async {
    var response = await http.post(routeAPI(routeName),
        headers: headers, body: encryptData(data));
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
