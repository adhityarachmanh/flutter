/*
module  : API SHR
creator : adhityarachmanh
os      : darwin19
created : Thu Dec 17 20:21:01 WIB 2020
product : ARH
version : v1.0
*/

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
      data: json['data'],
      creator: json['creator'],
    );
  }
}

class Rest {
  static String contentType = "Content-Type";
  static String appJSON = "application/json";
  static String authTokenKey = "Authorization";
  static String routeAPI(String routeName) {
    String url = "${config.apiConfig['API_URL']}/";
    String format = config.apiConfig['FORMAT'];
    List<String> formatSplit = format.split("/");
    for (var i = 0; i < formatSplit.length; i++) {
      var key = formatSplit[i];
      format = format.replaceAll(key, config.apiConfig[key]);
    }
    format += "/$routeName";

    url += format;
    return url;
  }

  Future<Map<String, String>> headerAsConfig(Map<String, String> _headers,
      {bool middleware = false}) async {
    var token = await global.getToken();
    if (token != null && middleware) {
      _headers[authTokenKey] = token;
    }
    _headers[contentType] = appJSON;
    return _headers;
  }

  Future get(String routeName,
      {Map<String, String> headers, middleware = false}) async {
    var _headers = headerAsConfig(headers, middleware: middleware);
    var response = await http.get(routeAPI(routeName), headers: await _headers);
    if (response.statusCode == 200) return response;
  }

  Future put(String routeName,
      {Map<String, dynamic> data,
      Map<String, String> headers,
      middleware = false}) async {
    var _headers = headerAsConfig(headers, middleware: middleware);
    var response = await http.post(routeAPI(routeName),
        headers: await _headers, body: jsonEncode(data));
    if (response.statusCode == 200) return response;
  }

  Future upload(String routeName, File file,
      {Map<String, dynamic> headers}) async {
    var request = http.MultipartRequest('POST', Uri.parse(routeAPI(routeName)));
    request.files.add(http.MultipartFile(
        'files', file.readAsBytes().asStream(), file.lengthSync(),
        filename: basename(file.path).split("/").last));
    var response = await request.send();
    if (response.statusCode == 200) return response;
  }

  Future fUpload(String routeName, File file,
      {Map<String, dynamic> data, Map<String, dynamic> headers}) async {
    var request = http.MultipartRequest('POST', Uri.parse(routeAPI(routeName)));
    request.fields['data'] = jsonEncode(data);
    request.files.add(http.MultipartFile(
        'files', file.readAsBytes().asStream(), file.lengthSync(),
        filename: basename(file.path).split("/").last));
    var response = await request.send();
    if (response.statusCode == 200) return response;
  }
}

final rest = new Rest();
