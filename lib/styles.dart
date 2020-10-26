part of 'app.dart';

int defaultMargin = 25;

Color primaryColor = HexColor.fromHex("#6762E3");
Color secondaryColor = HexColor.fromHex("#0558BA");

Color successColor = Color(0xFF3E9D9D);
Color warningColor = Color(0xFFFBD460);
Color errorColor = Color(0xFFFF5C83);

TextStyle textFontFC = GoogleFonts.firaCode(
  fontStyle: FontStyle.normal,
).copyWith(color: Colors.white, fontWeight: FontWeight.w500);

TextStyle textFontFS = GoogleFonts.firaSans(
  fontStyle: FontStyle.normal,
).copyWith(color: Colors.white, fontWeight: FontWeight.w500);
