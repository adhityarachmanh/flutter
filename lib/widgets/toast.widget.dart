import 'package:fluttertoast/fluttertoast.dart';

void showToast(String message, [int? timeInSec]) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: timeInSec != null ? timeInSec : 1,
  );
}
