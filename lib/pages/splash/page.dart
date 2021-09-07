/*
module  : SPLASH SCREEN
creator : adhityarachmanh
os      : darwin19
created : Thu May  6 12:21:22 WIB 2021
*/

import 'package:app/pages/splash/controller.dart';
import 'package:app/widgets/copyright.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app/config.dart';
import 'package:app/utils/size_config..dart';
import 'package:app/widgets/label.widget.dart';
import 'package:get/get.dart';

class SplashPage extends GetView<SplashController> {
  static final routeName = "/SplashPage";
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    SizeConfig().init(context);
    return FutureBuilder(
        future: controller.initialize(),
        builder: (_, snapshot) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              brightness: Brightness.dark,
              elevation: 0,
            ),
            body: Container(
              height: SizeConfig.screenHeight,
              width: SizeConfig.screenWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(),
                  Container(
                    width: SizeConfig.screenWidth * 0.25,
                    height: SizeConfig.screenWidth * 0.25,
                    child: Image.asset("assets/icons/logo.png"),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: LabelWidget(
                      Config.application,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: CopyrightWidget(),
          );
        });
  }
}
