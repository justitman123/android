import 'package:flutter/material.dart';

import 'SpinKitDoubleBounce1.dart';

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
                    SpinKitDoubleBounce1(
                      color: Colors.blue,
                    ),
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
