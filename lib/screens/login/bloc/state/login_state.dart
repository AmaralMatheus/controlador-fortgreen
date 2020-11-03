import 'package:meta/meta.dart';

abstract class LoginState {
  LoginState([List props = const []]);
}

class LoginUninitialized extends LoginState {
  final String email;

  LoginUninitialized({this.email}) : super([email]);

  @override
  String toString() => 'LoginUninitialized';
}

class LoginAuthenticated extends LoginState {
  @override
  String toString() => 'LoginAuthenticated';
}

class LoginUnauthenticated extends LoginState {
  final String email;

  LoginUnauthenticated({this.email}) : super([email]);

  @override
  String toString() => "LoginUnauthenticated { email: $email }";
}

class LoginLoading extends LoginState {
  @override
  String toString() => 'LoginLoading';
}

class LoginEmailOrPasswordEmpty extends LoginState {
  final bool emailIsEmpty;
  final bool passwordIsEmpty;

  LoginEmailOrPasswordEmpty({this.emailIsEmpty, this.passwordIsEmpty})
      : super([emailIsEmpty, passwordIsEmpty]);

  @override
  String toString() => 'LoginEmailOrPasswordEmpty';
}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure({@required this.error}) : super([error]);

  @override
  String toString() => 'LoginFailure { error: $error }';
}

class LoginForgotLoading extends LoginState {
  @override
  String toString() => 'LoginForgotLoading';
}

class LoginForgotSuccess extends LoginState {
  @override
  String toString() => 'LoginForgotSuccess';
}

class LoginForgotFailure extends LoginState {
  final String error;

  LoginForgotFailure({@required this.error}) : super([error]);

  @override
  String toString() => 'LoginForgotFailure { error: $error }';
}

class Logoff extends LoginState{
  @override
  String toString() => 'Logoff';
}
