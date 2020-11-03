import 'package:meta/meta.dart';

abstract class LoginEvent {
  LoginEvent([List props = const []]);
}

class Login extends LoginEvent {
  final String email;
  final String password;
  final bool remember;

  Login(
      {@required this.email, @required this.password, @required this.remember})
      : super([email, password]);

  @override
  String toString() => "Login { email: $email }";
}

class LoggedIn extends LoginEvent {
  final String token;
  final int id;
  final String email;
  final bool remember;

  LoggedIn(
      {@required this.token,
      @required this.id,
      @required this.email,
      @required this.remember})
      : super([token, id, email]);

  @override
  String toString() => 'LoggedIn { token: $token, id: $id, email: $email }';
}

class LoggedOut extends LoginEvent {
  @override
  String toString() => 'LoggedOut';
}

class LoginForgot extends LoginEvent {
  final String email;

  LoginForgot({@required this.email}) : super([email]);

  @override
  String toString() => "LoginForgot { email: $email }";
}
