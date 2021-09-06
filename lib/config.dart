/*
module  : CONFIG
creator : adhityarachmanh
os      : darwin19
created : Thu May  6 12:21:22 WIB 2021
*/

import 'dart:convert';
import 'constants/enum.dart';

class Config {
  static Environment mode = Environment.development;
  // app info
  static String application = "Initial App";
  static String defaultFont = "Nunito";
  static int copyright = 2021;
  static double version = 1.0;

  // RestAPI
  static String username = "";
  static String password = "";
  static String basicAuth =
      "Basic ${base64Encode(utf8.encode('$username:$password'))}";
  static String domainDevelopment = "";
  static String domainProduction = "";
  static String? domain = {
    Environment.development: Config.domainDevelopment,
    Environment.production: Config.domainProduction,
  }[mode];
}
