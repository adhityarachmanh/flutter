part of 'app.dart';

double defaultMargin = 25;

Color primaryColor = HexColor.fromHex("#4a4a4a");
Color secondaryColor = HexColor.fromHex("#f7f7f7");

Color successColor = Color(0xFF3E9D9D);
Color warningColor = Color(0xFFFBD460);
Color errorColor = Color(0xFFFF5C83);

TextStyle textFontFC = GoogleFonts.firaCode(
  fontStyle: FontStyle.normal,
).copyWith(color: Colors.white, fontWeight: FontWeight.w500);

TextStyle textFontFS = GoogleFonts.firaSans(
  fontStyle: FontStyle.normal,
).copyWith(color: Colors.white, fontWeight: FontWeight.w500);

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double defaultSize;
  static Orientation orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenHeight = _mediaQueryData.size.height;
    screenWidth = _mediaQueryData.size.width;
    orientation = _mediaQueryData.orientation;

    defaultSize = orientation == Orientation.landscape
        ? screenHeight * 0.024
        : screenWidth * 0.024;
  }
}