/*
module  : STYLING
creator : adhityarachmanh
os      : darwin19
created : Thu Dec 17 20:21:01 WIB 2020
product : ARH
version : v1.0
*/

part of 'app.dart';

double defaultMargin = 25;

Color primaryColor = HexColor.fromHex("#191923");
Color secondaryColor = HexColor.fromHex("#1975df");
Color lightColor = HexColor.fromHex("#FFFFFF");


Color successColor = HexColor.fromHex("#2ecc71");
Color warningColor = HexColor.fromHex("#f39c12");
Color errorColor = HexColor.fromHex("#e74c3c");

TextStyle fontVolkorn = GoogleFonts.vollkorn(fontStyle: FontStyle.normal);

TextStyle textLight = fontVolkorn.copyWith(color: lightColor, fontWeight: FontWeight.w500);
TextStyle textPrimary = fontVolkorn.copyWith(color: primaryColor, fontWeight: FontWeight.w500);
TextStyle textSecondary = fontVolkorn.copyWith(color: secondaryColor, fontWeight: FontWeight.w500);

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
