/*
module  : ROUTES
creator : adhityarachmanh
os      : darwin19
created : Thu Dec 17 20:21:01 WIB 2020
*/

import 'package:app/controllers/bindings/auth.binding.dart';
import 'package:app/screens/privacyandpolicy.screen.dart';
import 'package:app/screens/splash.screen.dart';
import 'package:app/screens/welcome.screen.dart';
import 'package:get/get.dart';

List<GetPage<dynamic>> pages = [
  GetPage(
    name: SplashScreen.routeName,
    page: () => SplashScreen(),
    binding: AuthBinding(),
  ),
  GetPage(
    name: PrivacyAndPolicyScreen.routeName,
    page: () => PrivacyAndPolicyScreen(),
  ),
  GetPage(
    name: WelcomeScreen.routeName,
    page: () => WelcomeScreen(),
  ),
];
