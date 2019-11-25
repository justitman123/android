import 'package:bmi_calculator/input_page/ChatModel.dart' show model;
import 'package:bmi_calculator/screens/homescreen/drawer/LoggedInDrawer.dart';
import 'package:flutter/material.dart';
import 'package:bmi_calculator/screens/homescreen/drawer/AnonimousDrawer.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return model.isLoggedIn ? LoggedInDrawer() : AnonimousDrawer();
  }
}
