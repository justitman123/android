import 'package:bmi_calculator/input_page/ChatModel.dart' show ChatModel, model;
import 'package:bmi_calculator/screens/registerscreen/MiddleLoginRegisterPage.dart';
import 'package:bmi_calculator/input_page/size/SizeConfig.dart';
import 'package:bmi_calculator/input_page/utils.dart';
import 'package:bmi_calculator/screens/homescreen/HomeScreen.dart';
import 'package:bmi_calculator/util/cache_manager.dart'
    show FileProvider, fileProvider;
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class AnonimousDrawer extends StatelessWidget {
  final drawerTiles = [
    {
      'title': 'Home',
      'leading': Icons.home,
      'function': MiddleLoginRegisterPage(),
    },
    {
      'title': 'Your Profile',
      'leading': Icons.person_pin,
      'function': MiddleLoginRegisterPage(),
    },
    {
      'title': 'Settings',
      'leading': Icons.settings,
      'function': MiddleLoginRegisterPage(),
    },
    {
      'title': 'Contact Us',
      'leading': Icons.contact_mail,
      'function': MiddleLoginRegisterPage(),
    },
    {
      'title': 'Help',
      'leading': Icons.info_outline,
      'function': MiddleLoginRegisterPage(),
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
                    Container(
                      margin: EdgeInsets.only(
                          top: SizeConfig.safeBlockVertical * 5),
                      padding:
                      EdgeInsets.all(SizeConfig.safeBlockHorizontal * 5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: CircleAvatar(
//                        backgroundImage: adssa,
                        radius: SizeConfig.safeBlockHorizontal * 12,
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