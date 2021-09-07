/*
module  : ROUTES
creator : adhityarachmanh
os      : darwin19
created : Thu Dec 17 20:21:01 WIB 2020
*/

import 'package:app/pages/Dashboard/controller.dart';
import 'package:app/pages/dashboard/page.dart';
import 'package:app/pages/privacyandpolicy/controller.dart';
import 'package:app/pages/privacyandpolicy/page.dart';
import 'package:app/pages/splash/controller.dart';
import 'package:app/pages/welcome/controller.dart';
import 'package:app/pages/welcome/page.dart';
import 'package:app/pages/splash/page.dart';
import 'package:app/services/auth.service.dart';
import 'package:get/get.dart';

List<GetPage<dynamic>> pages = [
  GetPage(
    name: SplashPage.routeName,
    page: () => SplashPage(),
    binding: SplashBinding(),
    bindings: [
      AuthBinding(),
    ],
  ),
  GetPage(
    name: PrivacyAndPolicyPage.routeName,
    page: () => PrivacyAndPolicyPage(),
    binding: PrivacyAndPolicyBinding(),
  ),
  GetPage(
    name: DashboardPage.routeName,
    page: () => DashboardPage(),
    binding: DashboardBinding(),
  ),
  GetPage(
    name: WelcomePage.routeName,
    page: () => WelcomePage(),
    binding: WelcomeBinding(),
  ),
];
