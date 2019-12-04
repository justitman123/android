import 'package:bmi_calculator/input_page/size/SizeConfig.dart';
import 'package:bmi_calculator/input_page/utils.dart';
import 'package:bmi_calculator/screens/registerscreen/LeftLoginPage.dart';
import 'package:bmi_calculator/screens/registerscreen/RightRegisterPage.dart';
import 'package:flutter/material.dart';

class MiddleLoginRegisterPage extends StatelessWidget {
  PageController _controller =
      new PageController(initialPage: 0, viewportFraction: 1.0);

  Widget LoginPage(PageController controller) {
    return LeftLoginPage(controller: controller);
  }

  Widget SignupPage(PageController controller) {
    return RightRegisterPage(
      controller: controller,
    );
  }

  final Color primary = colorCurve;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
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
                        child: LoginPage(_controller),
                      ),
                      new ConstrainedBox(
                        constraints: const BoxConstraints.expand(),
                        child: SignupPage(_controller),
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
