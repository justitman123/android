import 'package:bmi_calculator/input_page/size/SizeConfig.dart';
import 'package:bmi_calculator/repository/user_repository.dart';
import 'package:bmi_calculator/screens/authentication_bloc/authentication_bloc.dart';
import 'package:bmi_calculator/screens/authentication_bloc/authentication_event.dart';
import 'package:bmi_calculator/screens/loginregisterscreen/register/bloc/register_bloc.dart';
import 'package:bmi_calculator/screens/loginregisterscreen/register/bloc/register_event.dart';
import 'package:bmi_calculator/screens/loginregisterscreen/register/bloc/register_state.dart';
import 'package:bmi_calculator/to/OAuthUser.dart';
import 'package:bmi_calculator/util/userManagement.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_dialog/progress_dialog.dart';

class RightRegisterPage extends StatefulWidget {
  final PageController _controller;
  final UserRepository _userRepository;

  RightRegisterPage(
      {Key key,
      @required PageController controller,
      @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        _controller = controller,
        super(key: key);

  @override
  _RightRegisterPageState createState() => _RightRegisterPageState();
}

class _RightRegisterPageState extends State<RightRegisterPage>
    with SingleTickerProviderStateMixin {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final UserManagement userManagement = UserManagement();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool hidePass = true;
  RegisterBloc _registerBloc;

  UserRepository get _userRepository => widget._userRepository;

  PageController get _controller => widget._controller;

  @override
  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  Widget build(BuildContext context) {
    ProgressDialog pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: true);
    return BlocListener<RegisterBloc, RegisterState>(listener: (context, state) {
      if (state.isSubmitting) {
        Scaffold.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Registering...'),
                  CircularProgressIndicator(),
                ],
              ),
            ),
          );
      }
      if (state.isSuccess) {
        BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
        Navigator.of(context).pop();
      }
      if (state.isFailure) {
        Scaffold.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Registration Failure'),
                  Icon(Icons.error),
                ],
              ),
              backgroundColor: Colors.red,
            ),
          );
      }
    }, child:
        BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
      return Container(
        child: Form(
          key: _formKey,
          autovalidate: true,
          child: new Column(
            children: <Widget>[
              InkWell(
                child: Container(
                  margin:
                      EdgeInsets.only(top: SizeConfig.safeBlockVertical * 5),
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      _controller?.animateToPage(0,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.decelerate);
                    },
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 5),
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
                margin:
                    EdgeInsets.only(top: SizeConfig.safeBlockHorizontal * 1),
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
                margin:
                    EdgeInsets.only(top: SizeConfig.safeBlockHorizontal * 1),
                alignment: Alignment.center,
                padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                child: new Card(
                  child: TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.alternate_email,
                            color: Colors.redAccent),
                        hintText: "samarthagarwal@live.com",
                        labelStyle: TextStyle(
                          color: Colors.grey,
                        ),
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
              Container(
                width: SizeConfig.safeBlockHorizontal * 90,
                margin:
                    EdgeInsets.only(top: SizeConfig.safeBlockHorizontal * 1),
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
                margin:
                    EdgeInsets.only(top: SizeConfig.safeBlockHorizontal * 1),
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
                    signUpUser(pr);
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
    }));
  }

  Future signUpUser(ProgressDialog pr) async {
    FormState formState = _formKey.currentState;
    if (formState.validate()) {
      formState.reset();
      _showLoadingIndicator(pr);
      var response =
          await Dio().post('http://192.168.42.4:8060/uaa/auth/mobile', data: {
        "userName": _nameController.text.toString(),
        "password": _passwordController.text.toString(),
        "email": _emailController.text,
        "provider": "custom"
      });
      OAuthUser oAuthUser = OAuthUser.fromJSON(response.data);
      FirebaseUser user = await firebaseAuth.currentUser();
      if (user != null) {
        userManagement.createUser('123213', <String, dynamic>{
          'id': '123213',
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
      }
      pr.hide();
      _controller.animateToPage(0,
          duration: Duration(milliseconds: 800), curve: Curves.bounceOut);
    }
  }

  _showLoadingIndicator(ProgressDialog pr) {
    pr.style(
        message: 'Downloading file...',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    _registerBloc.add(
      EmailChanged(email: _emailController.text),
    );
  }

  void _onPasswordChanged() {
    _registerBloc.add(
      PasswordChanged(password: _passwordController.text),
    );
  }

  void _onFormSubmitted() {
    _registerBloc.add(
      Submitted(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }
}
