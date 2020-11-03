import 'dart:ui';
import 'package:flutter/services.dart';

import '../../../colors.dart';
import '../../../screens/login/bloc/login_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/loading.dart';
import 'package:flutter/material.dart';
import '../bloc/login.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> with TickerProviderStateMixin {
  LoginRepository _repo = LoginRepository();
  bool hidePassword = true, idle = false;
  TextEditingController user = TextEditingController();
  TextEditingController password = TextEditingController();
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  String userError, passwordError;
  dynamic username, token;
  bool remember = false, sending = false;
  Color userColor = Colors.grey, passwordColor = Colors.grey;

  @override
  void initState() {
    super.initState();
    _remember();
    _alreadyLogged(context);
  }

  _remember() async {
    username = await _repo.getUsername();
    if (username != null) {
      user.text = username['username'];
      setState(() {
        remember = true;
      });
    }
  }

  void _onLoginButtonPressed(context) {
    this._bloc.dispatch(Login(
        email: user.text.trim(), password: password.text, remember: remember));
  }

  void _showDialog(BuildContext context, String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Erro ao realizar login!',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            content: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(message,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w200,
                        fontSize: 15,
                      )),
                  SizedBox(height: 10),
                  RaisedButton(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.transparent,
                        width: 1,
                        style: BorderStyle.solid
                      ), 
                      borderRadius: BorderRadius.circular(50)
                    ),
                    padding: EdgeInsets.zero,
                    color: Palette.purple,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(45)),
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width -
                          (MediaQuery.of(context).size.width * 0.05),
                      height: MediaQuery.of(context).size.height * 0.075,
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: 
                        Text('Ok', style: TextStyle(color: Colors.white))),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ]),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
          );
        });
  }

  void _validate(context) {
    setState(() {
      this.sending = true;

      if (this.user.text.isEmpty) {
        this.userError = 'Informe o usuário';
        this.sending = false;
        this.userColor = Colors.red;
      } else {
        this.userError = null;
        this.userColor = Colors.grey;
      }

      if (this.password.text.isEmpty) {
        this.passwordError = 'Informe a senha';
        this.sending = false;
        this.passwordColor = Colors.red;
      } else {
        this.passwordError = null;
        this.passwordColor = Colors.grey;
      }
    });

    if (passwordError == null && userError == null) {
      this._onLoginButtonPressed(context);
    }
  }

  LoginBloc _bloc = LoginBloc();

  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: BlocListener(
            bloc: this._bloc,
            listener: (context, state) async {
              if (state is LoginAuthenticated) {
                await Navigator.of(context).pushReplacementNamed('home');
              }

              if (state is LoginFailure) {
                this._showDialog(context, state.error);
                setState(() {
                  this.sending = false;
                });
              }
            },
            child: Scaffold(
              backgroundColor: Colors.black,
                  body: idle ? Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: GestureDetector(
                      onTap: () => FocusScope.of(context).unfocus(),
                      child: Center(
                        child: Container(
                          width: 400,
                          height: 500,
                          child: Column(
                            children: [
                              _textTop(),
                              Text(
                                'LOGIN',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 22.5
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: MediaQuery.of(context)
                                            .size
                                            .width *
                                        0.06),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    _userBox(),
                                    _passwordBox(),
                                    SizedBox(height: 15),
                                  ],
                                ),
                              ),
                              Container(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  children: [
                                    SizedBox(height: 15),
                                    _loginButton(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ) : SizedBox())),
                );
  }

  Widget _textTop() => Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: MediaQuery.of(context).size.height * 0.1,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.275,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/png/logo.png')
          )
        ),
      )
  );

  Widget _userBox() => Container(
      // padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border(
            bottom: BorderSide(color: userError != null ? Colors.red : Colors.grey, width: 1))),
      child: TextField(
        style: TextStyle(color: Colors.white),
        cursorColor: Colors.grey,
        controller: this.user,
        focusNode: emailFocus,
        decoration: InputDecoration(
            hintText: "Email",
            hintStyle: TextStyle(color: Colors.white),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),
            suffixIcon: Icon(Icons.person_outline, color: this.userColor)),
      ));

  Widget _passwordBox() => Container(
        // padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border(
              bottom: BorderSide(color: passwordError != null ? Colors.red : Colors.grey,
                width: 1))),
        child: TextField(
            style: TextStyle(color: Colors.white),
            cursorColor: Colors.grey,
            obscureText: this.hidePassword,
            controller: this.password,
            decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.white),
                hintText: "Senha",
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
                suffixIcon: IconButton(
                    icon: this.hidePassword
                        ? Icon(Icons.visibility_off)
                        : Icon(Icons.visibility),
                    color: this.passwordColor,
                    onPressed: () => setState(
                        () => this.hidePassword = !this.hidePassword)))),
      );

  Widget _rememberMe() => GestureDetector(
      onTap: () => setState(() {
            remember = !remember;
          }),
      child: Container(
          // padding: EdgeInsets.symmetric(horizontal: 20),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Lembrar de mim',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                )),
            Container(
              width: 20,
              height: 20,
              padding: EdgeInsets.zero,
              margin: EdgeInsets.only(right: 14),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 1, color: Colors.grey)),
              child: remember
                  ? Icon(
                      Icons.check_circle,
                      color: Palette.purple,
                      size: 18,
                    )
                  : SizedBox(),
            )
          ])));

  Widget _forgotPassword() =>
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          alignment: Alignment.center,
          height: 25,
          child: InkWell(
              child: Text('Esqueci a senha',
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w200)),
              onTap: () =>
                  Navigator.of(context).pushReplacementNamed('reset-password')),
        )
      ]);

  Widget _loginButton() => Center(
          child: RaisedButton(
        elevation: 10,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.transparent,
            width: 1,
            style: BorderStyle.solid
          ), 
          borderRadius: BorderRadius.circular(50)
        ),
        padding: EdgeInsets.zero,
        color: Colors.green,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(45)),
          alignment: Alignment.center,
          width: 300,
          height: 60,
          padding: EdgeInsets.symmetric(vertical: 5),
          child: this.sending
              ? Container(
                  height: 15,
                  width: 15,
                  child: CenteredLoadingItem(
                      animationColor: Palette.greenMossDark))
              : Text('Login', style: TextStyle(color: Colors.white)),
        ),
        onPressed: () {
          this._validate(context);
        },
      ));

  _alreadyLogged(context) async {
    dynamic token = await _repo.getToken();
    if (token != null) {
      await Navigator.of(context).pushReplacementNamed('home');
    } else {
      setState(() {
        idle = true;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
