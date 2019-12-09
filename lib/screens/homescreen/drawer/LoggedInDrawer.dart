import 'package:bmi_calculator/input_page/size/SizeConfig.dart';
import 'package:bmi_calculator/input_page/utils.dart';
import 'package:bmi_calculator/screens/homescreen/HomeScreen.dart';
import 'package:bmi_calculator/screens/loginregisterscreen/MiddleLoginRegisterPage.dart';
import 'package:bmi_calculator/util/cache_manager.dart'
    show FileProvider, fileProvider;
import 'package:flutter/material.dart';

class LoggedInDrawer extends StatelessWidget {
  String _name;

  LoggedInDrawer({name}) : this._name = name;


  String get name => _name;

  set name(String value) {
    _name = value;
  }

  final drawerTiles = [
    {
      'title': 'Home',
      'leading': Icons.home,
      'function': MiddleLoginRegisterPage(),
    },
    {
      'title': 'Аккаунт',
      'leading': Icons.person_pin,
      'function': MiddleLoginRegisterPage(),
    },
    {
      'title': 'Настройки',
      'leading': Icons.settings,
      'function': MiddleLoginRegisterPage(),
    },
    {
      'title': 'Связь с командой разработчиков',
      'leading': Icons.contact_mail,
      'function': MiddleLoginRegisterPage(),
    },
    {
      'title': 'Благотворительная помощь проекту',
      'leading': Icons.info_outline,
      'function': MiddleLoginRegisterPage(),
    },
  ];
  final Color primary = colorCurve;
  ImageProvider photo;

  @override
  Widget build(BuildContext context) {
    fileProvider.openInputFile('sdfds.jpg').then((result) {
      photo = result;
    });
    return ClipPath(
      clipper: OvalRightBorderClipper(),
      child: Container(
        color: primary,
        width: SizeConfig.safeBlockVertical * 100,
        padding: EdgeInsets.only(right: SizeConfig.safeBlockVertical * 15),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 5),
              padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: CircleAvatar(
                backgroundImage: photo,
                radius: SizeConfig.safeBlockHorizontal * 12,
              ),
            ),
            Container(
              child: Text(
                _name,
                style: TextStyle(color: Colors.white),
              ),
            ),
            Container(
              child: Text(
                "@JennyAn28",
                style: TextStyle(color: Color.fromRGBO(255, 255, 255, 0.5)),
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
  }
}
