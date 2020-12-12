part of '../app.dart';

class ResponseAPI {
  int s;
  String msg;
  dynamic data;
  String creator;
  ResponseAPI({@required this.s, this.msg, this.data, this.creator});
  factory ResponseAPI.fromJson(Map<String, dynamic> json) {
    if (config.encryptionMode && json['data'] != null) {
      json['data'] = jsonDecode(global.dec(json['data'], 2, 6));
    }
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
  static String multipartFormData = "multipart/form-data";
  static String authTokenKey = "Authorization";
  static String routeAPI(String routeName) {
    String url = config.apiConfig['FORMAT'];
    List<String> formatSplit = url.split("/");
    for (var i = 0; i < formatSplit.length; i++) {
      var key = formatSplit[i];
      url.replaceAll(key, config.apiConfig[key]);
    }
    url += "/$routeName";
    return url;
  }

  static dynamic encryptData(data) {
    Map<String, dynamic> newData = {
      "creator": config.creatorName,
      "data": null,
    };
    if (config.encryptionMode) {
      newData['data'] = global.enc(jsonEncode(data), 2, 6);
    } else {
      newData['data'] = data;
    }

    return jsonEncode(newData);
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
        headers: await _headers, body: encryptData(data));
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
