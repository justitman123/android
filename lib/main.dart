import 'dart:io';

import 'package:bmi_calculator/screens/registerscreen/MiddleLoginRegisterPage.dart';
import 'package:bmi_calculator/screens/splashscreen/SplashScreen.dart';
import 'package:bmi_calculator/input_page/size/SizeConfig.dart';
import 'package:bmi_calculator/screens/templogin/ui/loginPage.dart';
import 'package:bmi_calculator/screens/templogin/ui/login_page.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter UI Collections',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CollectionApp(),
    );
  }
}

class CollectionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Theme.of(context).primaryColor,
        ),
        home: SplashScreen());
  }
}
