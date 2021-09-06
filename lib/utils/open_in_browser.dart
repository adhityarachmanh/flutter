import 'dart:io';
import 'package:android_intent/android_intent.dart';
import 'package:url_launcher/url_launcher.dart';

openBrowser(String link) async {
  if (Platform.isAndroid) {
    final AndroidIntent intent =
        AndroidIntent(action: 'action_view', data: link);
    intent.launch();
  } else if (Platform.isIOS) {
    if (await canLaunch(link)) {
      await launch(link);
    } else {
      throw 'Could not launch $link';
    }
  }
}
