import 'package:meta/meta.dart';

@immutable
class RegisterState {
  final bool isUserNameValid;
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isPasswordConfirmed;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isFormValid => isUserNameValid && isEmailValid && isPasswordValid && isPasswordConfirmed;

  RegisterState({
    @required this.isEmailValid,
    @required this.isUserNameValid,
    @required this.isPasswordValid,
    @required this.isPasswordConfirmed,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure,
  });

  factory RegisterState.empty() {
    return RegisterState(
      isUserNameValid: true,
      isEmailValid: true,
      isPasswordValid: true,
      isPasswordConfirmed: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory RegisterState.loading() {
    return RegisterState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory RegisterState.failure() {
    return RegisterState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  factory RegisterState.success() {
    return RegisterState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  RegisterState update({
    bool isUserNameValid,
    bool isEmailValid,
    bool isPasswordValid,
    bool isPasswordConfirmed,
  }) {
    return copyWith(
      isUserNameValid: isUserNameValid,
      isEmailValid: isEmailValid,
      isPasswordValid: isPasswordValid,
      isPasswordConfirmed: isPasswordConfirmed,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  RegisterState copyWith({
    bool isUserNameValid,
    bool isEmailValid,
    bool isPasswordValid,
    bool isPasswordConfirmed,
    bool isSubmitEnabled,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
  }) {
    return RegisterState(
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isUserNameValid: isUserNameValid ?? this.isUserNameValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isPasswordConfirmed: isPasswordConfirmed ?? this.isPasswordConfirmed,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  @override
  String toString() {
    return '''RegisterState {
      isEmailValid: $isEmailValid,
      isPasswordValid: $isPasswordValid,      
      isPasswordConfirmed: $isPasswordConfirmed,      
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
    }''';
  }
}
