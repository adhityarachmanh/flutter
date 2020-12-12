part of 'app.dart';

class Config {
  Map<String, dynamic> apiConfig = {
    "BASE": "res",
    // CHANGE API URL | AVD DEFAULT LOCAL IP http://10.0.2.2:PORT
    "API_URL": 'URL', 
    "VERSION": "v1.0", 
    // FORMAT API EX:https://example.com/v.1.0/res/{route}
    "FORMAT": "VERSION/BASE"
  }; 
  String creator = 'CREATOR';
  String creatorName = "CREATOR_NAME";
  bool encryptionMode = false;
}

final config = new Config();
