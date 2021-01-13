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

class Palette {
  // COLOR
  static Color primaryColor = HexColor.fromHex("#191923");
  static Color secondaryColor = HexColor.fromHex("#1975df");
  static Color lightColor = HexColor.fromHex("#FFFFFF");

  static Color successColor = HexColor.fromHex("#2ecc71");
  static Color warningColor = HexColor.fromHex("#f39c12");
  static Color errorColor = HexColor.fromHex("#e74c3c");
}

class MyFont {
  // FONT
  static TextStyle montserrat =
      GoogleFonts.montserrat(fontStyle: FontStyle.normal);
}

class MyText {
  // TEXT
  static TextStyle light({@required TextStyle font}) {
    return font.copyWith(
        color: Palette.lightColor, fontWeight: FontWeight.w500);
  }

  static TextStyle primary({@required TextStyle font}) {
    return font.copyWith(
        color: Palette.primaryColor, fontWeight: FontWeight.w500);
  }

  static TextStyle secondary({@required TextStyle font}) {
    return font.copyWith(
        color: Palette.secondaryColor, fontWeight: FontWeight.w500);
  }
}



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
