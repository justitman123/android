import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bmi_calculator/blocs/login_register_bloc/registerbloc/bloc/register_event.dart';
import 'package:bmi_calculator/blocs/login_register_bloc/registerbloc/bloc/register_state.dart';
import 'package:bmi_calculator/repository/user_repository.dart';
import 'package:bmi_calculator/validators.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository _userRepository;

  RegisterBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  RegisterState get initialState => RegisterState.empty();

  @override
  Stream<RegisterState> transformEvents(
    Stream<RegisterEvent> events,
    Stream<RegisterState> Function(RegisterEvent event) next,
  ) {
    final observableStream = events as Observable<RegisterEvent>;
    final nonDebounceStream = observableStream.where((event) {
      return (event is! EmailChanged &&
          event is! PasswordChanged &&
          event is! UserNameChanged &&
          event is! PasswordConfirmed);
    });
    final debounceStream = observableStream.where((event) {
      return (event is EmailChanged ||
          event is PasswordChanged ||
          event is UserNameChanged ||
          event is PasswordConfirmed);
    }).debounceTime(Duration(milliseconds: 300));
    return super
        .transformEvents(nonDebounceStream.mergeWith([debounceStream]), next);
  }

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is UserNameChanged) {
      yield* _mapUserNameChangedToState(event.userName);
    } else if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is PasswordConfirmed) {
      yield* _mapPasswordConfirmedToState(
          event.password, event.passwordConfirmed);
    } else if (event is Submitted) {
      yield* _mapFormSubmittedToState(
          event.userName, event.email, event.password);
    }
  }

  Stream<RegisterState> _mapUserNameChangedToState(String userName) async* {
    yield state.update(
      isUserNameValid: Validators.isValidUserName(userName),
    );
  }

  Stream<RegisterState> _mapEmailChangedToState(String email) async* {
    yield state.update(
      isEmailValid: Validators.isValidEmail(email),
    );
  }

  Stream<RegisterState> _mapPasswordChangedToState(String password) async* {
    yield state.update(
      isPasswordValid: Validators.isValidPassword(password),
    );
  }

  Stream<RegisterState> _mapPasswordConfirmedToState(
      String password, String passwordConfirmed) async* {
    yield state.update(
      isPasswordValid:
          Validators.isPasswordConfirmed(password, passwordConfirmed),
    );
  }

  Stream<RegisterState> _mapFormSubmittedToState(
    String userName,
    String email,
    String password,
  ) async* {
    yield RegisterState.loading();
    try {
      await _userRepository.signUp(
        email: email,
        password: password,
      );
      yield RegisterState.success();
    } catch (_) {
      yield RegisterState.failure();
    }
  }
}
