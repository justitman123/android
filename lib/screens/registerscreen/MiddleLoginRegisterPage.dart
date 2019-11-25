import 'package:bmi_calculator/input_page/loginScreen/auth/googleSignIn.dart';
import 'package:bmi_calculator/input_page/size/SizeConfig.dart';
import 'package:bmi_calculator/screens/registerscreen/RightRegisterPage.dart';
import 'package:bmi_calculator/screens/registerscreen/pages/LeftLoginPage.dart';
import 'package:bmi_calculator/widget_utils.dart';
import 'package:flutter/material.dart';

class MiddleLoginRegisterPage extends StatefulWidget {
  @override
  _MiddleLoginRegisterPageState createState() =>
      new _MiddleLoginRegisterPageState();
}

class _MiddleLoginRegisterPageState extends State<MiddleLoginRegisterPage>
    with TickerProviderStateMixin {
  Auth auth = Auth();

  Animation animation, delayAnimation, muchDelayedAnimation;
  AnimationController animationController;
  bool hidePass = true;
  bool isLoading = false;
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000),
    );
    animation = Tween(begin: -1.0, end: 0.0).animate(
      CurvedAnimation(curve: Curves.fastOutSlowIn, parent: animationController),
    );
    delayAnimation = Tween(begin: -1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
      ),
    );
    muchDelayedAnimation = Tween(begin: -1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(0.7, 1.0, curve: Curves.fastOutSlowIn),
      ),
    );

    isSignedIn();
  }

  void isSignedIn() async {
    setState(() {
      isLoading = true;
    });
//    preferences = await SharedPreferences.getInstance();
    if (isLoggedIn) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }
    setState(() {
      isLoading = false;
    });
  }

  PageController _controller =
      new PageController(initialPage: 1, viewportFraction: 1.0);

  Widget HomePage() {
    SizeConfig().init(context);
    return new Container(
      height: SizeConfig.safeBlockVertical * 10,
      decoration: BoxDecoration(
        color: const Color(0xFF610AA5),
      ),
      child: new Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: screenAwareSize(250.0, context)),
            child: Center(
              child: Icon(
                Icons.headset_mic,
                color: Colors.white,
                size: screenAwareSize(40.0, context),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: screenAwareSize(20.0, context)),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "AwesomeApp",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: SizeConfig.safeBlockHorizontal * 5,
                    decoration: TextDecoration.none,
                  ),
                ),
              ],
            ),
          ),
          new Container(
            width: SizeConfig.safeBlockHorizontal * 90,
            margin: EdgeInsets.only(top: 150),
            alignment: Alignment.center,
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new FlatButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    color: Colors.white,
                    onPressed: () => gotoSignup(),
                    child: new Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 20.0,
                      ),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Expanded(
                            child: Text(
                              "SIGN UP",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          new Container(
            width: SizeConfig.safeBlockHorizontal * 90,
            margin: const EdgeInsets.only(top: 30.0),
            alignment: Alignment.center,
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new FlatButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    color: Colors.white,
                    onPressed: () => gotoLogin(),
                    child: new Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 20.0,
                      ),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Expanded(
                            child: Text(
                              "Connect using a social network",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget LoginPage() {
    return LeftLoginPage();
  }

  Widget SignupPage() {
    return RightRegisterPage();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        child: PageView(
          controller: _controller,
          physics: new AlwaysScrollableScrollPhysics(),
          children: <Widget>[LoginPage(), HomePage(), SignupPage()],
          scrollDirection: Axis.horizontal,
        ));
  }

  gotoLogin() {
    //controller_0To1.forward(from: 0.0);
    _controller.animateToPage(
      0,
      duration: Duration(milliseconds: 800),
      curve: Curves.bounceOut,
    );
  }

  gotoSignup() {
    //controller_minus1To0.reverse(from: 0.0);
    _controller.animateToPage(
      2,
      duration: Duration(milliseconds: 800),
      curve: Curves.bounceOut,
    );
  }
}
