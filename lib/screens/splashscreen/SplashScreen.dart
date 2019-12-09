import 'dart:async';

import 'package:bmi_calculator/input_page/ChatModel.dart' show ChatModel, model;
import 'package:bmi_calculator/input_page/loginScreen/localstorage/LocalStorage.dart';
import 'package:bmi_calculator/input_page/size/SizeConfig.dart';
import 'package:bmi_calculator/screens/homescreen/HomeScreen.dart';
import 'package:bmi_calculator/util/cache_manager.dart'
    show FileProvider, fileProvider;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    initializeProfileData();
    Timer(Duration(seconds: 2), () {
      navigateFromSplash();
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(body: Center(child: Container(child: Text('111fdgfdg'))));
  }

  Future navigateFromSplash() async {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  Future initializeProfileData() async {
    String accessToken =
        await LocalStorage.instance.storage.read(key: 'accessToken');
    if (model.accessToken != null) {
      String photoUrl =
          await LocalStorage.instance.storage.read(key: 'photoUrl');
      String name =
          await LocalStorage.instance.storage.read(key: 'displayName');
      model.setPhotoUrl(photoUrl);
      model.setName(name);
      model.setAccessToken(accessToken);
      model.setLoggedIn(true);
      var response = await Dio()
          .get(photoUrl, options: Options(responseType: ResponseType.bytes));
      fileProvider.saveInputFile('avatar.jpg', response.data);
    } else {
      model.setLoggedIn(false);
    }
  }
}