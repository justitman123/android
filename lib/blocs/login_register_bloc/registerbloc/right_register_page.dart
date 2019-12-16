import 'package:bmi_calculator/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:bmi_calculator/blocs/authentication_bloc/authentication_event.dart';
import 'package:bmi_calculator/blocs/login_register_bloc/registerbloc/bloc/register_bloc.dart';
import 'package:bmi_calculator/blocs/login_register_bloc/registerbloc/bloc/register_state.dart';
import 'package:bmi_calculator/blocs/login_register_bloc/registerbloc/register_button.dart';
import 'package:bmi_calculator/input_page/size/SizeConfig.dart';
import 'package:bmi_calculator/repository/user_repository.dart';
import 'package:bmi_calculator/util/userManagement.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'bloc/register_event.dart';

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
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool hidePass = true;
  RegisterBloc _registerBloc;

  UserRepository get _userRepository => widget._userRepository;

  PageController get _controller => widget._controller;

  bool get isPopulated =>
      _userNameController.text.isNotEmpty &&
      _emailController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty;

  bool isRegisterButtonEnabled(RegisterState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    _userNameController.addListener(_onUserNameChanged);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
    _confirmPasswordController.addListener(_onPasswordConfirmed);
  }

  @override
  Widget build(BuildContext context) {
    ProgressDialog pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: true);
    return BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
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
                    controller: _userNameController,
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
                      _userNameController.text = val;
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
              RegisterButton(
                onPressed:
                    isRegisterButtonEnabled(state) ? _onFormSubmitted : null,
              )
            ],
          ),
        ),
      );
    }));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onUserNameChanged() {
    _registerBloc.add(
      UserNameChanged(userName: _userNameController.text),
    );
  }

  void _onEmailChanged() {
    _registerBloc.add(
      EmailChanged(email: _emailController.text),
    );
  }

  void _onPasswordConfirmed() {
    _registerBloc.add(
      PasswordConfirmed(
          password: _passwordController.text,
          passwordConfirmed: _confirmPasswordController.text),
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
        userName: _userNameController.text,
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }
}
