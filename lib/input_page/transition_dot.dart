import 'dart:math' as math;

import 'package:bmi_calculator/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class  extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}



class TransitionDot extends AnimatedWidget {
  TransitionDot({Key key, Listenable animation})
      : super(key: key, listenable: animation);

  Animation<int> get positionAnimation => IntTween(
        begin: 0,
        end: 50,
      ).animate(
        CurvedAnimation(
          parent: super.listenable,
          curve: Interval(0.15, 0.3),
        ),
      );

  @override
  Widget build(BuildContext context) {
    double scaledSize = screenAwareSize(52, context);
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    double height = math.min(scaledSize, deviceHeight);
    double width = math.min(scaledSize, deviceWidth);
    Decoration decoration = BoxDecoration(
      shape: width < 0.9 * deviceWidth ? BoxShape.circle : BoxShape.rectangle,
      color: Theme.of(context).primaryColor,
    );

    return IgnorePointer(
      child: Opacity(
        opacity: positionAnimation.value > 0 ? 1.0 : 0.0,
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Spacer(flex: 104 - positionAnimation.value),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SpinKitDoubleBounce(color: Colors.blue),
                  ],
                ),
                Spacer(flex: 4 + positionAnimation.value),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
