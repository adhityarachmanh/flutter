import 'dart:io';
import 'package:android_intent/android_intent.dart';
import 'package:url_launcher/url_launcher.dart';

openMap(String link) async {
  if (Platform.isAndroid) {
    final AndroidIntent intent = AndroidIntent(
        action: 'action_view',
        data: Uri.encodeFull('google.navigation:q=$link'),
        package: 'com.google.android.apps.maps');
    intent.launch();
  } else if (Platform.isIOS) {
    if (await canLaunch(link)) {
      await launch(
          "https://www.google.co.id/maps/search/${link.replaceAll(' ', '+')}");
    } else {
      throw 'Could not launch $link';
    }
  }
}
