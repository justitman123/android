import 'package:bmi_calculator/input_page/colors.dart';
import 'package:bmi_calculator/input_page/loginScreen/googleSignIn/googleSignIn.dart';
import 'package:bmi_calculator/input_page/responsive_screen.dart';
import 'package:bmi_calculator/input_page/size/SizeConfig.dart';
import 'package:bmi_calculator/widget_utils.dart';
import 'package:flutter/material.dart';

class LoginScreen3 extends StatefulWidget {
  @override
  _LoginScreen3State createState() => new _LoginScreen3State();
}

class _LoginScreen3State extends State<LoginScreen3>
    with TickerProviderStateMixin {
// Google sign in
  Auth auth = Auth();
// Google sign in

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
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

  Widget HomePage() {
    SizeConfig().init(context);
    return new Container(
      height: SizeConfig.safeBlockVertical * 10,
      decoration: BoxDecoration(
        color: const Color(0xFF610AA5),
        image: DecorationImage(
          colorFilter: new ColorFilter.mode(
              Colors.black.withOpacity(0.1), BlendMode.dstATop),
          image: AssetImage('assets/images/mountains.jpg'),
          fit: BoxFit.cover,
        ),
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
    return new Container(
      height: SizeConfig.safeBlockVertical * 10,
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          colorFilter: new ColorFilter.mode(
              Colors.black.withOpacity(0.05), BlendMode.dstATop),
          image: AssetImage('assets/images/mountains.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Form(
        key: _formKey,
        autovalidate: true,
        child: new Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 10),
              child: Center(
                child: Icon(
                  Icons.headset_mic,
                  color: Colors.redAccent,
                  size: SizeConfig.safeBlockVertical * 7,
                ),
              ),
            ),
            new Row(
              children: <Widget>[
                new Expanded(
                  child: new Padding(
                    padding: const EdgeInsets.only(left: 40.0),
                    child: new Text(
                      "EMAIL",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent,
                          fontSize: SizeConfig.safeBlockHorizontal * 3,
                          decoration: TextDecoration.none),
                    ),
                  ),
                ),
              ],
            ),
            new Container(
              width: SizeConfig.safeBlockHorizontal * 90,
              margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      color: Colors.redAccent,
                      width: 0.5,
                      style: BorderStyle.solid),
                ),
              ),
              padding: const EdgeInsets.only(left: 0.0, right: 10.0),
              child: new Card(
                child: TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  obscureText: true,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'samarthagarwal@live.com',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Please Provide Email";
                    }
                  },
                  onSaved: (val) {
                    _emailController.text = val;
                  },
                  autocorrect: true,
                ),
              ),
            ),
            Divider(
              height: SizeConfig.safeBlockHorizontal * 1,
            ),
            new Row(
              children: <Widget>[
                new Expanded(
                  child: new Padding(
                    padding: const EdgeInsets.only(left: 40.0),
                    child: new Text(
                      "PASSWORD",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                        fontSize: SizeConfig.safeBlockHorizontal * 3,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            new Container(
              width: SizeConfig.safeBlockHorizontal * 90,
              margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      color: Colors.redAccent, style: BorderStyle.solid),
                ),
              ),
              padding: const EdgeInsets.only(left: 0.0, right: 10.0),
              child: new Card(
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '*********',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                  validator: (val) {
                    if (val.length < 6) {
                      return "Passsword must contain atleast 6 characters";
                    } else if (val.isEmpty) {
                      return "Password field can't be empty";
                    }
                    // return "";
                  },
                  onSaved: (val) {
                    _passwordController.text = val;
                  },
                  autocorrect: true,
                ),
              ),
            ),
            Divider(
              height: SizeConfig.safeBlockHorizontal * 1,
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: new FlatButton(
                    child: new Text(
                      "Forgot Password?",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                        fontSize: SizeConfig.safeBlockHorizontal * 3,
                      ),
                      textAlign: TextAlign.end,
                    ),
                    onPressed: () => {},
                  ),
                ),
              ],
            ),
            new Container(
              width: SizeConfig.safeBlockHorizontal * 90,
              margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
              alignment: Alignment.center,
              child: new Row(
                children: <Widget>[
                  new Expanded(
                    child: new FlatButton(
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                      color: Colors.redAccent,
                      onPressed: () => {},
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
                                "LOGIN",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
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
              margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
              alignment: Alignment.center,
              child: Row(
                children: <Widget>[
                  new Expanded(
                    child: new Container(
                      margin: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(border: Border.all(width: 0.25)),
                    ),
                  ),
                  Text(
                    "OR CONNECT WITH",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: SizeConfig.safeBlockHorizontal * 3,
                    ),
                  ),
                  new Expanded(
                    child: new Container(
                      margin: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(border: Border.all(width: 0.25)),
                    ),
                  ),
                ],
              ),
            ),
            new Container(
              width: SizeConfig.safeBlockHorizontal * 90,
              margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
              child: new Row(
                children: <Widget>[
                  new Expanded(
                    child: new Container(
                      margin: EdgeInsets.only(right: 8.0),
                      alignment: Alignment.center,
                      child: new Row(
                        children: <Widget>[
                          new Expanded(
                            child: new FlatButton(
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0),
                              ),
                              color: Color(0Xff3B5998),
                              onPressed: () => {},
                              child: new Container(
                                child: new Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new Expanded(
                                      child: new FlatButton(
                                        onPressed: () => {},
                                        padding: EdgeInsets.only(
                                          top: 20.0,
                                          bottom: 20.0,
                                        ),
                                        child: new Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Icon(
                                              const IconData(0xea90,
                                                  fontFamily: 'icomoon'),
                                              color: Colors.white,
                                              size:
                                                  screenAwareSize(15.0, context),
                                            ),
                                            Text(
                                              "FACEBOOK",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
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
                  ),
                  new Expanded(
                    child: new Container(
                      margin: EdgeInsets.only(left: 8.0),
                      alignment: Alignment.center,
                      child: new Row(
                        children: <Widget>[
                          new Expanded(
                            child: new FlatButton(
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0),
                              ),
                              color: Color(0Xffdb3236),
                              onPressed: () => {},
                              child: new Container(
                                child: new Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new Expanded(
                                      child: new FlatButton(
                                        onPressed: () async {
                                          await auth.googleSignIn();
                                        },
                                        padding: EdgeInsets.only(
                                          top: 20.0,
                                          bottom: 20.0,
                                        ),
                                        child: new Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Icon(
                                              const IconData(0xea88,
                                                  fontFamily: 'icomoon'),
                                              color: Colors.white,
                                              size:
                                                  screenAwareSize(15.0, context),
                                            ),
                                            Text(
                                              "GOOGLE",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
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
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget SignupPage() {
    return new Container(
      height: SizeConfig.safeBlockVertical * 10,
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          colorFilter: new ColorFilter.mode(
              Colors.black.withOpacity(0.05), BlendMode.dstATop),
          image: AssetImage('assets/images/mountains.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: new Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 10),
            child: Center(
              child: Icon(
                Icons.headset_mic,
                color: Colors.redAccent,
                size: SizeConfig.safeBlockVertical * 7,
              ),
            ),
          ),
          new Row(
            children: <Widget>[
              new Expanded(
                child: new Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: new Text(
                    "LOGIN",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                        fontSize: SizeConfig.safeBlockHorizontal * 3,
                        decoration: TextDecoration.none),
                  ),
                ),
              ),
            ],
          ),
          new Container(
            width: SizeConfig.safeBlockHorizontal * 90,
            margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    color: Colors.redAccent,
                    width: SizeConfig.safeBlockVertical * 0.1,
                    style: BorderStyle.solid),
              ),
            ),
            padding: const EdgeInsets.only(left: 0.0, right: 10.0),
            child: new Card(
              child: TextField(
                obscureText: true,
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ),
          Divider(
            height: SizeConfig.safeBlockVertical * 1,
          ),
          new Row(
            children: <Widget>[
              new Expanded(
                child: new Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: new Text(
                    "EMAIL",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                        fontSize: SizeConfig.safeBlockHorizontal * 3,
                        decoration: TextDecoration.none),
                  ),
                ),
              ),
            ],
          ),
          new Container(
            width: SizeConfig.safeBlockHorizontal * 100,
            margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    color: Colors.redAccent,
                    width: SizeConfig.safeBlockVertical * 0.1,
                    style: BorderStyle.solid),
              ),
            ),
            padding: const EdgeInsets.only(left: 0.0, right: 10.0),
            child: new Card(
              child: TextField(
                obscureText: true,
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'samarthagarwal@live.com',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ),
          Divider(
            height: SizeConfig.safeBlockVertical * 1,
          ),
          new Row(
            children: <Widget>[
              new Expanded(
                child: new Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: new Text(
                    "PASSWORD",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                        fontSize: SizeConfig.safeBlockHorizontal * 3,
                        decoration: TextDecoration.none),
                  ),
                ),
              ),
            ],
          ),
          new Container(
            margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    color: Colors.redAccent,
                    width: screenAwareSize(0.5, context),
                    style: BorderStyle.solid),
              ),
            ),
            padding: const EdgeInsets.only(left: 0.0, right: 10.0),
            child: new Card(
              child: TextField(
                obscureText: true,
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '*********',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ),
          Divider(
            height: SizeConfig.safeBlockVertical * 1,
          ),
          new Row(
            children: <Widget>[
              new Expanded(
                child: new Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: new Text(
                    "CONFIRM PASSWORD",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                        fontSize: SizeConfig.safeBlockHorizontal * 3,
                        decoration: TextDecoration.none),
                  ),
                ),
              ),
            ],
          ),
          new Container(
            margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    color: Colors.redAccent, style: BorderStyle.solid),
              ),
            ),
            padding: const EdgeInsets.only(left: 0.0, right: 10.0),
            child: Card(
              child: TextField(
                obscureText: true,
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '*********',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ),
          Divider(
            height: SizeConfig.safeBlockVertical * 1,
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: new FlatButton(
                  child: new Text(
                    "Already have an account?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
                      fontSize: SizeConfig.safeBlockHorizontal * 3,
                    ),
                    textAlign: TextAlign.end,
                  ),
                  onPressed: () => {},
                ),
              ),
            ],
          ),
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 50.0),
            alignment: Alignment.center,
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new FlatButton(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(
                          screenAwareSize(30.0, context)),
                    ),
                    color: Colors.redAccent,
                    onPressed: () => {},
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
                                  color: Colors.white,
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

  PageController _controller =
      new PageController(initialPage: 1, viewportFraction: 1.0);

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
}
