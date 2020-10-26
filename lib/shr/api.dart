part of '../app.dart';

var contentType = "Content-Type",
    appJSON = "application/json",
    multipartFormData = "multipart/form-data",
    xToken = 'XA',
    serviceBase = config.res,
    api = config.api;

class Rest {
  static String routeAPI(String routeName) {
    return "$api/$serviceBase/$routeName";
  }

  Future get(String routeName, headers) async {
    var response = await http.get(routeAPI(routeName), headers: headers);
    if (response.statusCode == 200) return response;
  }

  Future put(String routeName, object, headers) async {
    var response = await http.post(routeAPI(routeName),
        headers: headers, body: jsonEncode(object));

    if (response.statusCode == 200) return response;
  }

  Future upload(
      String routeName, File file, Map<String, dynamic> headers) async {
    var request = http.MultipartRequest('POST', Uri.parse(routeAPI(routeName)));
    request.files.add(http.MultipartFile(
        'file', file.readAsBytes().asStream(), file.lengthSync(),
        filename: basename(file.path).split("/").last));
    var response = await request.send();
    if (response.statusCode == 200) return response;
  }

  Future fUpload(String routeName, File file, Map<String, dynamic> data,
      Map<String, dynamic> headers) async {
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
