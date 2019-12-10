import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class EmailChanged extends RegisterEvent {
  final String email;

  const EmailChanged({@required this.email});

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'EmailChanged { email :$email }';
}

class PasswordChanged extends RegisterEvent {
  final String password;

  const PasswordChanged({@required this.password});

  @override
  List<Object> get props => [password];

  @override
  String toString() => 'PasswordChanged { password: $password }';
}

class UserNameChanged extends RegisterEvent {
  final String userName;

  const UserNameChanged({@required this.userName});

  @override
  List<Object> get props => [userName];

  @override
  String toString() => 'PasswordChanged { password: $userName }';
}

class PasswordConfirmed extends RegisterEvent {
  final String password;
  final String passwordConfirmed;

  const PasswordConfirmed({@required this.password, @required this.passwordConfirmed});

  @override
  List<Object> get props => [password, passwordConfirmed];

  @override
  String toString() => 'PasswordConfirmed { password: $passwordConfirmed }';
}

class Submitted extends RegisterEvent {
  final String userName;
  final String email;
  final String password;

  const Submitted({
    @required this.userName,
    @required this.email,
    @required this.password,
  });

  @override
  List<Object> get props => [email, password, userName];

  @override
  String toString() {
    return 'Submitted { userName: $userName, email: $email, password: $password }';
  }
}
