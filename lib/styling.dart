part of 'app.dart';

double defaultMargin = 25;

Color primaryColor = HexColor.fromHex("#191923");
Color secondaryColor = HexColor.fromHex("#1975df");

Color successColor = HexColor.fromHex("#2ecc71");
Color warningColor = HexColor.fromHex("#f39c12");
Color errorColor = HexColor.fromHex("#e74c3c");


TextStyle textPrimary = GoogleFonts.roboto(
  fontStyle: FontStyle.normal,
).copyWith(color: primaryColor, fontWeight: FontWeight.w500);

TextStyle textSecondary = GoogleFonts.roboto(
  fontStyle: FontStyle.normal,
).copyWith(color: secondaryColor, fontWeight: FontWeight.w500);

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