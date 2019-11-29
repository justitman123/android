import 'package:bmi_calculator/input_page/size/SizeConfig.dart';
import 'package:bmi_calculator/to/OAuthUser.dart';
import 'package:bmi_calculator/util/userManagement.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RightRegisterPage extends StatefulWidget {
  PageController controller;

  RightRegisterPage({this.controller});

  @override
  _RightRegisterPageState createState() => _RightRegisterPageState();
}

class _RightRegisterPageState extends State<RightRegisterPage>
    with SingleTickerProviderStateMixin {
  PageController _controller;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  UserManagement userManagement = UserManagement();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
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
      height: SizeConfig.safeBlockVertical * 10,
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
            Container(
              width: SizeConfig.safeBlockHorizontal * 90,
              margin: const EdgeInsets.only(top: 10.0),
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 0.0, right: 10.0),
              child: new Card(
                child: TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    prefixIcon:
                        Icon(Icons.account_box, color: Colors.redAccent),
                    hintText: "Username",
                    labelText: "Username",
                  ),
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Please Provide Username";
                    }
                  },
                  onSaved: (val) {
                    _nameController.text = val;
                  },
                  autocorrect: true,
                ),
              ),
            ),
            Container(
              width: SizeConfig.safeBlockHorizontal * 90,
              margin: const EdgeInsets.only(top: 10.0),
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 0.0, right: 10.0),
              child: new Card(
                child: TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      prefixIcon:
                          Icon(Icons.alternate_email, color: Colors.redAccent),
                      hintText: "Email",
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      labelText: "Email"),
                  // ignore: missing_return
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
            Container(
              width: SizeConfig.safeBlockHorizontal * 90,
              margin: const EdgeInsets.only(top: 10.0),
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
            Container(
              width: SizeConfig.safeBlockHorizontal * 90,
              margin: const EdgeInsets.only(top: 10.0),
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 0.0, right: 10.0),
              child: Card(
                child: TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: hidePass,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.remove_red_eye,
                          color: Colors.blueGrey,
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
                      hintText: "Confirm Password",
                      labelText: "Confirm Password"),
                  // ignore: missing_return
                  validator: (val) {
                    if (val.length < 6) {
                      return "Passsword must contain atleast 6 characters";
                    } else if (val.isEmpty) {
                      return "Password field can't be empty";
                    } else if (_passwordController.text != val) {
                      return "Password and Confirm Password didn't match";
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
            Container(
              margin: EdgeInsets.only(
                  left: SizeConfig.safeBlockVertical * 5,
                  right: SizeConfig.safeBlockVertical * 5,
                  top: SizeConfig.safeBlockVertical * 8),
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(
                      SizeConfig.safeBlockVertical * 10),
                ),
                color: Colors.redAccent,
                onPressed: () async {
                  signUpUser();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20.0,
                    horizontal: 20.0,
                  ),
                  child: Center(
                    child: Text(
                      "SIGN UP",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future signUpUser() async {
    FormState formState = _formKey.currentState;
    if (formState.validate()) {
      formState.reset();
      _showLoadingIndicator();
      var response =
          await Dio().post('http://192.168.42.4:8060/uaa/auth/mobile', data: {
        "userName": _nameController.text.toString(),
        "password": _passwordController.text.toString(),
        "email": _emailController.text,
        "provider": "custom"
      });
      OAuthUser oAuthUser = OAuthUser.fromJSON(response.data);
      if (oAuthUser != null) {
        firebaseAuth
            .createUserWithEmailAndPassword(
                email: _emailController.text,
                password: _passwordController.text)
            .then((user) {
          // user.sendEmailVerification();
          // here user.uid triggers an id inside the user which should match id of the user document
          userManagement.createUser(oAuthUser.id.toString(), {
            'id': oAuthUser.id.toString(),
            'user_name': _nameController.text.toString(),
            'email': _emailController.text,
            'password': oAuthUser.password,
            'avatar_url': oAuthUser.avatarUrl,
            'failure_count': oAuthUser.failureCount,
            'failure_time': oAuthUser.failureTime,
            'provider': oAuthUser.provider,
            'registered': oAuthUser.registered.millisecondsSinceEpoch,
          }).CatchError((e) {
            print(e.toString());
          });
        });
        _controller.animateToPage(0,
            duration: Duration(milliseconds: 800), curve: Curves.bounceOut);
      }
    }
  }

  _showLoadingIndicator() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          content: Row(
            children: <Widget>[
              CircularProgressIndicator(),
              SizedBox(
                width: 20.0,
              ),
              Text("Loading!")
            ],
          ),
        );
      },
    );
  }
}
