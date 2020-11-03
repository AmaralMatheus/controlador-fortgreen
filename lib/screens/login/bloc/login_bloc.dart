import 'dart:async';

import 'package:bloc/bloc.dart';
import './login_repository.dart';

import './state/login_state.dart';
import './event/login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository _loginRepository = LoginRepository();

  @override
  LoginState get initialState => LoginUninitialized();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is Login) {
      yield LoginLoading();

      if (event.email.isEmpty || event.password.isEmpty) {
        yield LoginEmailOrPasswordEmpty(
          emailIsEmpty: event.email.isEmpty,
          passwordIsEmpty: event.password.isEmpty,
        );
      } else {
        try {
          final Map<String, dynamic> response = await this
              ._loginRepository
              .authenticate(email: event.email, password: event.password);


          if (response['id'] != null) {
            dispatch(LoggedIn(
                token: response['token'],
                id: response['id'],
                email: event.email,
                remember: event.remember));
          } else {
            yield LoginFailure(error: "Usuário inválido!");
          }
        } catch (error) {
          yield LoginFailure(error: error.toString());
        }
      }
    }

    if (event is LoggedIn) {
      yield LoginLoading();
      await _loginRepository.persistToken(event.token);
      if (event.remember) await _loginRepository.persistEmail(event.email);
      await _loginRepository.persistId(event.id);
      yield LoginAuthenticated();
    }

    if (event is LoggedOut) {
      yield LoginLoading();
      await _loginRepository.deleteClientData();
      yield LoginUnauthenticated();
    }

    if (event is LoginForgot) yield* forgotPassword(event);
  }

  Stream<LoginState> forgotPassword(LoginForgot event) async* {
    yield LoginForgotLoading();

    try {
      await _loginRepository.forgotPassword(email: event.email.trim());
      yield LoginForgotSuccess();
    } catch (error) {
      yield LoginForgotFailure(error: error.message);
    }
  }
}
