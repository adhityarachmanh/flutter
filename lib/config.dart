part of 'app.dart';

// CHANGE API URL | AVD DEFAULT LOCAL IP http://10.0.2.2:PORT
// FORMAT API EX:https://example.com/v.1.0/res/{route}
class Config {
  String websocket = "ws://";
  Map<String, dynamic> apiConfig = {
    "BASE": "res",
    "API_URL": 'URL',
    "VERSION": "v1.0",
    "FORMAT": "VERSION/BASE"
  };
  String creator = 'CREATOR';
  String creatorName = "CREATOR_NAME";
  bool encryptionMode = false;
}

final config = new Config();
