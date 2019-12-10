import 'package:bloc/bloc.dart';
import 'package:bmi_calculator/repository/user_repository.dart';
import 'package:bmi_calculator/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:bmi_calculator/blocs/authentication_bloc/authentication_event.dart';
import 'package:bmi_calculator/screens/splashscreen/SplashScreen.dart';
import 'package:bmi_calculator/simple_bloc_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final UserRepository userRepository = UserRepository();
  runApp(
    BlocProvider(
      create: (context) => AuthenticationBloc(
        userRepository: userRepository,
      )..add(AppStarted()),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter UI Collections',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Theme.of(context).primaryColor,
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen());
  }
}
