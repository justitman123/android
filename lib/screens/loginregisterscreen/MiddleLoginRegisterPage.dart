import 'package:bmi_calculator/input_page/size/SizeConfig.dart';
import 'package:bmi_calculator/input_page/utils.dart';
import 'package:bmi_calculator/repository/user_repository.dart';
import 'package:bmi_calculator/screens/loginregisterscreen/LeftLoginPage.dart';
import 'package:bmi_calculator/screens/loginregisterscreen/RightRegisterPage.dart';
import 'package:bmi_calculator/screens/loginregisterscreen/login/bloc/login_bloc.dart';
import 'package:bmi_calculator/screens/loginregisterscreen/register/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MiddleLoginRegisterPage extends StatelessWidget {
  final UserRepository _userRepository = UserRepository();

  PageController _controller =
      new PageController(initialPage: 0, viewportFraction: 1.0);

  final Color primary = colorCurve;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        width: SizeConfig.safeBlockHorizontal * 100,
        height: SizeConfig.safeBlockVertical * 100 >= 450.0
            ? SizeConfig.safeBlockVertical * 100
            : 450.0,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: PageView(
                controller: _controller,
                children: <Widget>[
                  new ConstrainedBox(
                    constraints: const BoxConstraints.expand(),
                    child: BlocProvider<LoginBloc>(
                      create: (context) =>
                          LoginBloc(userRepository: _userRepository),
                      child: LeftLoginPage(userRepository: _userRepository,
                        controller: _controller,
                      ),
                    ),
                  ),
                  new ConstrainedBox(
                    constraints: const BoxConstraints.expand(),
                    child: BlocProvider<RegisterBloc>(
                      create: (context) =>
                          RegisterBloc(userRepository: _userRepository),
                      child: RightRegisterPage(
                        userRepository: _userRepository,
                        controller: _controller,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
