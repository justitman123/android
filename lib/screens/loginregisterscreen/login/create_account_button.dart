//import 'package:bmi_calculator/repository/user_repository.dart';
//import 'package:bmi_calculator/blocs/login_register_bloc/registerbloc/register_screen.dart';
//import 'package:flutter/material.dart';
//
//class CreateAccountButton extends StatelessWidget {
//  final UserRepository _userRepository;
//
//  CreateAccountButton({Key key, @required UserRepository userRepository})
//      : assert(userRepository != null),
//        _userRepository = userRepository,
//        super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return FlatButton(
//      child: Text(
//        'Create an Account',
//      ),
//      onPressed: () {
//        Navigator.of(context).push(
//          MaterialPageRoute(builder: (context) {
//            return RegisterScreen(userRepository: _userRepository);
//          }),
//        );
//      },
//    );
//  }
//}
