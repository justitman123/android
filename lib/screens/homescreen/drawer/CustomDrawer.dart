import 'package:bmi_calculator/input_page/ChatModel.dart' show ChatModel, model;
import 'package:bmi_calculator/input_page/ChatModel.dart' as prefix0;
import 'package:bmi_calculator/input_page/loginScreen/LoginScreen3.dart';
import 'package:bmi_calculator/input_page/loginScreen/localstorage/LocalStorage.dart';
import 'package:bmi_calculator/input_page/size/SizeConfig.dart';
import 'package:bmi_calculator/input_page/utils.dart';
import 'package:bmi_calculator/screens/homescreen/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CustomDrawer extends StatelessWidget {
  final drawerTiles = [
    {
      'title': 'Home',
      'leading': Icons.home,
      'function': LoginScreen3(),
    },
    {
      'title': 'Your Profile',
      'leading': Icons.person_pin,
      'function': LoginScreen3(),
    },
    {
      'title': 'Settings',
      'leading': Icons.settings,
      'function': LoginScreen3(),
    },
    {
      'title': 'Contact Us',
      'leading': Icons.contact_mail,
      'function': LoginScreen3(),
    },
    {
      'title': 'Help',
      'leading': Icons.info_outline,
      'function': LoginScreen3(),
    },
  ];
  final Color primary = colorCurve;

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ChatModel>(
        model: model,
        child: ScopedModelDescendant<ChatModel>(builder:
            (BuildContext inContext, Widget inChild, ChatModel inModel) {
          return ClipPath(
            clipper: OvalRightBorderClipper(),
            child: Container(
              color: primary,
              width: SizeConfig.safeBlockVertical * 100,
              padding:
                  EdgeInsets.only(right: SizeConfig.safeBlockVertical * 15),
              child: Column(
                children: <Widget>[
                  Visibility(
                    visible: LocalStorage.instance.storage
                            .read(key: 'accessToken') !=
                        null,
                    child: Expanded(
                      flex: 2,
                      child: Container(
                        margin: EdgeInsets.only(
                            top: SizeConfig.safeBlockVertical * 5),
                        padding:
                            EdgeInsets.all(SizeConfig.safeBlockHorizontal * 5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: CircleAvatar(
                          backgroundImage: model.avatar,
                          radius: SizeConfig.safeBlockHorizontal * 20,
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: LocalStorage.instance.storage
                            .read(key: 'accessToken') !=
                        null,
                    child: Container(
                      child: Text(
                        model.name,
                        style: TextStyle(color: Colors.white),
                      ),
                      margin: EdgeInsets.only(
                          top: SizeConfig.safeBlockVertical * 1),
                    ),
                  ),
                  Visibility(
                    visible: LocalStorage.instance.storage
                            .read(key: 'accessToken') !=
                        null,
                    child: Container(
                      child: Text(
                        "@JennyAn28",
                        style: TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 0.5)),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: ListView.builder(
                      itemCount: drawerTiles.length * 2,
                      itemBuilder: (context, i) {
                        if (i.isOdd)
                          return Divider(
                            color: Color.fromRGBO(255, 255, 255, 0.5),
                            indent: 20,
                          );
                        return InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      drawerTiles[i ~/ 2]['function']));
                            },
                            child: ListTile(
                              title: Text(
                                drawerTiles[i ~/ 2]['title'],
                                style: TextStyle(color: Colors.white),
                              ),
                              leading: Icon(
                                drawerTiles[i ~/ 2]['leading'],
                                color: Color.fromRGBO(255, 255, 255, 0.5),
                              ),
                            ));
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }));
  }
}
