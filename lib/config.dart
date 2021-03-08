/*
module  : CONFIG
creator : adhityarachmanh
os      : darwin19
created : Thu Dec 17 20:21:01 WIB 2020
product : ARH
version : v1.0
*/

part of 'app.dart';

/* 
NOTE :
CHANGE API URL | AVD DEFAULT LOCAL IP http://10.0.2.2:PORT
FORMAT API EX: VERSION/BASE v.1.0/res || BASE res (key from apiConfig)
*/

class Config {
  String websocket = "ws://";
  Map<String, dynamic> apiConfig = {
    "res": "res",
    "API_URL": 'URL',
    "VERSION": "v1.0",
    "FORMAT": "res"
  };
  Map<String, dynamic> copyright = {
    "Creator":"",
    "ProductId": "",
    "Product": "",
    "Description": "",
    "Copyright": "",
    "Version": "1.0"
  };
}

final config = new Config();
