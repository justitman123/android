import 'package:bmi_calculator/input_page/loginScreen/auth/googleSignIn.dart';
import 'package:bmi_calculator/input_page/size/SizeConfig.dart';
import 'package:flutter/material.dart';

class LeftLoginPage extends StatefulWidget {
  PageController controller;

  LeftLoginPage({this.controller});

  @override
  _LeftLoginPageState createState() => _LeftLoginPageState();
}

class _LeftLoginPageState extends State<LeftLoginPage> {
  PageController _controller;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  Auth auth = Auth();
  bool hidePass = true;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
//    isSignedIn();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: BoxDecoration(
        color: Colors.white,
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
            new Container(
              width: SizeConfig.safeBlockHorizontal * 90,
              margin: EdgeInsets.only(top: SizeConfig.safeBlockHorizontal * 1),
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 0.0, right: 10.0),
              child: new Card(
                child: TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      prefixIcon:
                          Icon(Icons.alternate_email, color: Colors.redAccent),
                      hintText: 'samarthagarwal@live.com',
                      hintStyle: TextStyle(color: Colors.grey),
                      labelText: "Email"),
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
            new Container(
              width: SizeConfig.safeBlockHorizontal * 90,
              margin: EdgeInsets.only(top: SizeConfig.safeBlockHorizontal * 1),
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 0.0, right: 10.0),
              child: new Card(
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: hidePass,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.remove_red_eye,
                          color: Colors.redAccent,
                        ),
                        onPressed: () {
                          setState(() {
                            hidePass = false;
                          });
                        },
                      ),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.blueGrey,
                      ),
                      hintText: "Password",
                      labelText: "Password"),
                  validator: (val) {
                    if (val.length < 6) {
                      return "Passsword must contain atleast 6 characters";
                    }
                  },
                  onSaved: (val) {
                    _passwordController.text = val;
                  },
                  autocorrect: true,
                ),
              ),
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
              margin: EdgeInsets.only(left: 30.0, right: 30.0, top: SizeConfig.safeBlockHorizontal * 1),
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
                        padding: EdgeInsets.symmetric(
                          vertical: SizeConfig.safeBlockVertical * 3,
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
                      decoration:
                          BoxDecoration(border: Border.all(width: 0.25)),
                    ),
                  ),
                  Text(
                    "OR REGISTER",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: SizeConfig.safeBlockHorizontal * 3,
                    ),
                  ),
                  new Expanded(
                    child: new Container(
                      margin: EdgeInsets.all(8.0),
                      decoration:
                          BoxDecoration(border: Border.all(width: 0.25)),
                    ),
                  ),
                ],
              ),
            ),
            new Container(
              width: SizeConfig.safeBlockHorizontal * 90,
              margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 15.0),
              alignment: Alignment.center,
              child: new Row(
                children: <Widget>[
                  new Expanded(
                    child: new FlatButton(
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                      color: Colors.redAccent,
                      onPressed: () => {
                        _controller?.animateToPage(1,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.decelerate)
                      },
                      child: new Container(
                        padding: EdgeInsets.symmetric(
                          vertical: SizeConfig.safeBlockVertical * 3,
                          horizontal: 20.0,
                        ),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Expanded(
                              child: Text(
                                "REGISTER",
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
                      decoration:
                          BoxDecoration(border: Border.all(width: 0.25)),
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
                      decoration:
                          BoxDecoration(border: Border.all(width: 0.25)),
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
                                                  SizeConfig.safeBlockVertical *
                                                      3,
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
                                                  SizeConfig.safeBlockVertical *
                                                      3,
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
}
