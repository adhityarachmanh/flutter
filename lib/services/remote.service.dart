import 'package:get/get.dart';
import 'package:http/http.dart';

class RemoteService extends GetConnect {
  static Future login(String username, String password) async {
    var response = await post(Uri.parse(""), body: {});
    try {} catch (e) {}
  }

  static Future silentLogin(Map data) async {
    try {} catch (e) {}
  }

  static Future getData() async {
    try {} catch (e) {}
  }
}
