part of 'app.dart';

class Config {
  Map<String, dynamic> apiConfig = {
    "BASE": "res",
    "API_URL": 'http://10.0.2.2:PORT',// AVD DEFAULT IP
    "VERSION": "v1.0",
    "FORMAT": "API_URL/VERSION/BASE"// FORMAT API
  }; 
  String creator = 'CREATOR';
  String creatorName = "CREATOR_NAME";
  bool encryptionMode = false;
}

final config = new Config();
