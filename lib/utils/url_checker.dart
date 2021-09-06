part of '../app.dart';

bool urlChecker(link) {
  String regexSource =
      "^(https?)://[-a-zA-Z0-9+&@#/%?=~_|!:,.;]*[-a-zA-Z0-9+&@#/%=~_|]";
  final regex = RegExp(regexSource);
  final matches = regex.allMatches(link);
  for (Match match in matches) {
    if (match.start == 0 && match.end == link.length) {
      return true;
    }
  }
  return false;
}
