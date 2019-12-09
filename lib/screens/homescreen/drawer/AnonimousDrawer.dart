import 'package:bmi_calculator/input_page/size/SizeConfig.dart';
import 'package:bmi_calculator/input_page/utils.dart';
import 'package:bmi_calculator/screens/homescreen/HomeScreen.dart';
import 'package:bmi_calculator/screens/loginregisterscreen/MiddleLoginRegisterPage.dart';
import 'package:bmi_calculator/screens/templogin/ui/loginPage.dart';
import 'package:bmi_calculator/screens/templogin/ui/login_page.dart';
import 'package:flutter/material.dart';

class AnonymousDrawer extends StatelessWidget {
  final drawerTiles = [
    {
      'title': 'Вход и регистрация',
      'leading': Icons.person_pin,
      'function': Login(),
    },
    {
      'title': 'Связь с командой разработчиков',
      'leading': Icons.contact_mail,
      'function': MiddleLoginRegisterPage(),
    },
    {
      'title': 'Благотворительная помощь проекту',
      'leading': Icons.info_outline,
      'function': LoginPage(),
    },
  ];
  final Color primary = colorCurve;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipPath(
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
                          Navigator.pop(context);
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
      ),
    );
  }
}
