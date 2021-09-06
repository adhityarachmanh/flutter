/*
module  : ROUTES
creator : adhityarachmanh
os      : darwin19
created : Thu Dec 17 20:21:01 WIB 2020
*/

import 'package:app/controllers/auth.controller.dart';
import 'package:app/pages/auth/signin.page.dart';
import 'package:app/pages/dashboard.page.dart';
import 'package:app/pages/privacyandpolicy.page.dart';
import 'package:app/pages/splash.page.dart';
import 'package:app/pages/welcome.page.dart';
import 'package:get/get.dart';

List<GetPage<dynamic>> pages = [
  GetPage(
    name: SplashPage.routeName,
    page: () => SplashPage(),
  ),
  GetPage(
    name: SigninPage.routeName,
    page: () => SigninPage(),
  ),
  GetPage(
    name: PrivacyAndPolicyPage.routeName,
    page: () => PrivacyAndPolicyPage(),
  ),
  GetPage(
    name: DashboardPage.routeName,
    page: () => DashboardPage(),
  ),
  GetPage(
    name: WelcomePage.routeName,
    page: () => WelcomePage(),
  ),
];
