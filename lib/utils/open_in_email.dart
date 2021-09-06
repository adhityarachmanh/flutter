import 'dart:io';

import 'package:android_intent/android_intent.dart';
import 'package:url_launcher/url_launcher.dart';

openEmail(String email, String subject) async {
  if (Platform.isAndroid) {
    final AndroidIntent intent = AndroidIntent(
        action: 'action_view', data: "mailto:$email?subject=$subject");
    intent.launch();
  } else if (Platform.isIOS) {
    final Uri _emailLaunchUri = Uri(
        scheme: 'mailto', path: email, queryParameters: {'subject': subject});
    launch(_emailLaunchUri.toString());
  }
}
