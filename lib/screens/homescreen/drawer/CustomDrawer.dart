import 'package:bmi_calculator/input_page/size/SizeConfig.dart';
import 'package:bmi_calculator/repository/user_repository.dart';
import 'package:bmi_calculator/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:bmi_calculator/blocs/authentication_bloc/authentication_state.dart';
import 'package:bmi_calculator/screens/homescreen/drawer/AnonimousDrawer.dart';
import 'package:bmi_calculator/screens/homescreen/drawer/LoggedInDrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        SizeConfig().init(context);
        if (state is Unauthenticated) {
          return AnonymousDrawer();
        }
        if (state is Authenticated) {
          return LoggedInDrawer(name: state.displayName);
        }
      },
    );
  }
}
