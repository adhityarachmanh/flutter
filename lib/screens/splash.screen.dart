import 'dart:async';

import 'package:app/config.dart';
import 'package:app/constants/colors.dart';
import 'package:app/controllers/auth.controller.dart';
import 'package:app/screens/privacyandpolicy.screen.dart';
import 'package:app/utils/size_config..dart';
import 'package:app/widgets/copyright.widget.dart';
import 'package:app/widgets/label.widget.dart';
import 'package:app/widgets/loadingindicator.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class SplashScreen extends StatelessWidget {
  static final routeName = "/SplashScreen";
  Future<void> initialize() async {
    Box box = Hive.box('GUEST');

    box.deleteAll(box.keys);
    Timer(Duration(seconds: 3), () async {
      bool privacyAndPolicy = box.get('privacyAndPolicy', defaultValue: false);
      if (privacyAndPolicy) {
        await Get.find<AuthController>().silentLogin();
      } else {
        Get.offNamed(PrivacyAndPolicyScreen.routeName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return FutureBuilder(
        future: initialize(),
        builder: (_, snapshot) {
          return Scaffold(
            backgroundColor: Palette.colorWhite,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              brightness: Brightness.dark,
              elevation: 0.0,
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
                  Container(
                      margin: EdgeInsets.only(top: 25),
                      height: 30,
                      child: GetX<AuthController>(
                        builder: (value) => Visibility(
                          visible: value.isLoading,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 20,
                                width: 20,
                                child: LoadingIndicatorWidget(),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              LabelWidget(
                                "Check Authentication...",
                                fontSize: 16,
                                color: Palette.colorBlack,
                              )
                            ],
                          ),
                        ),
                      )),
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
