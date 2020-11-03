import 'package:controlador/colors.dart';
import 'package:controlador/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets/loading.dart';
import 'bloc/login.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController controller = TextEditingController();
  FocusNode focus = FocusNode();
  String error;
  Color color = Colors.grey;
  LoginBloc _bloc = LoginBloc();
  bool sending = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => BlocListener(
        bloc: this._bloc,
        listener: (context, state) {
          SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark
              .copyWith(statusBarBrightness: Brightness.dark));

          if (state is LoginForgotSuccess) {
            setState(() {
              this.sending = false;
            });
            _showModalSheet(
                'Caso o e-mail ' +
                    controller.text +
                    ' esteja cadastrado na controlador, em breve você receberá instruções para alteração da senha.',
                true);
          }
          if (state is LoginForgotFailure) {
            setState(() {
              this.sending = false;
            });
            _showModalSheet(
                "Por favor, verifique se a alteração de senha está sendo realizada na plataforma correta!",
                false);
          }
        },
        child: Scaffold(
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Center(
              child: Theme(
                data: ThemeData(primaryColor: Colors.white),
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/png/background-home.png'),
                          fit: BoxFit.cover)),
                  child: Stack(
                    children: [
                      Container(
                          alignment: Alignment.topRight,
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(top: 50, right: 25),
                          child: Image.asset('assets/png/icons/logo.png',
                              width: 200, height: 200)),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              alignment: Alignment.bottomCenter,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                      child: Text('Esqueci a senha',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 29,
                                              fontWeight: FontWeight.w600))),
                                  Text(
                                    'Digite o e-mail cadastrado para que possamos recuperar a sua senha',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                        top: 25, left: 20, right: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('E-mail',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600)),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: this.error != null
                                              ? Colors.red
                                              : Colors.white,
                                          width: 1),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(
                                          45,
                                        ),
                                      ),
                                    ),
                                    child: TextField(
                                      controller: controller,
                                      focusNode: focus,
                                      decoration: InputDecoration(
                                          focusedBorder: InputBorder.none,
                                          border: InputBorder.none),
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: Text(
                                      error != null ? error : '',
                                      maxLines: 2,
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: RaisedButton(
                                padding: EdgeInsets.zero,
                                color: Colors.transparent,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Palette.greenMossMedium,
                                      borderRadius: BorderRadius.circular(15)),
                                  alignment: Alignment.center,
                                  height: MediaQuery.of(context).size.height *
                                      0.075,
                                  child: this.sending
                                      ? Container(
                                          height: 15,
                                          width: 15,
                                          child: CenteredLoadingItem(
                                            animationColor: Colors.black,
                                          ),
                                        )
                                      : Text(
                                          'Enviar',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                onPressed: () {
                                  setState(() {
                                    this.sending = true;
                                    if (this.controller.text.isEmpty) {
                                      this.color = Colors.red;
                                      this.error = 'Informe um e-mail';
                                      this.sending = false;
                                    } else if (!(isValidEmail(
                                        this.controller.text))) {
                                      this.color = Colors.red;
                                      this.error = 'Formato de e-mail inválido';
                                      this.sending = false;
                                    } else {
                                      this.color = Colors.grey;
                                      this.error = null;
                                      this._bloc.dispatch(
                                          LoginForgot(email: controller.text));
                                    }
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          floatingActionButton: Visibility(
            visible: MediaQuery.of(context).viewInsets.bottom == 0,
            child: Container(
              margin: EdgeInsets.only(top: 100),
              child: FloatingActionButton(
                focusElevation: 0,
                hoverElevation: 0,
                highlightElevation: 0,
                backgroundColor: Colors.transparent,
                elevation: 0,
                child: Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('login');
                },
              ),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        ),
      );

  void _showModalSheet(String message, bool success) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Solicitação de alteração de senha",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            content: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(message,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontWeight: FontWeight.w200,
                        fontSize: 15,
                      )),
                  SizedBox(height: 10),
                  RaisedButton(
                    padding: EdgeInsets.zero,
                    color: Colors.transparent,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Palette.propertyGreen,
                          borderRadius: BorderRadius.circular(25)),
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.75,
                      height: MediaQuery.of(context).size.height * 0.075,
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child:
                          (Text('Ok', style: TextStyle(color: Colors.white))),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    onPressed: () {
                      success
                          ? Navigator.of(context).pushReplacementNamed('login')
                          : Navigator.of(context).pop();
                    },
                  )
                ]),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0)),
          );
        });
  }
}
