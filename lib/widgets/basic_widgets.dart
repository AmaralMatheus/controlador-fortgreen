import 'package:controlador/colors.dart';
import 'package:controlador/screens/login/bloc/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BasicLoadingWidget extends StatelessWidget {
  final String message;

  BasicLoadingWidget({this.message});

  @override
  Widget build(BuildContext context) => Container(
        color: Colors.transparent,
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(top: 50),
            child: Column(
              children: <Widget>[
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Palette.greenMedium,
                  ),
                  strokeWidth: 2,
                ),
                SizedBox(height: 10),
                Text(message)
              ],
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ),
        ),
      );
}

class BasicLoadingRetry extends StatelessWidget {
  final bloc;
  final event;
  final BuildContext context;
  final Color fontColor;

  BasicLoadingRetry(
      {this.bloc, this.event, this.context, this.fontColor = Colors.black});

  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                "Erro ao tentar carregar",
                style: TextStyle(color: this.fontColor),
              ),
              SizedBox(height: 20),
              FlatButton(
                onPressed: () {
                  bloc.dispatch(event);
                },
                padding: EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 2, color: this.fontColor),
                  borderRadius: BorderRadius.all(
                    Radius.circular(45),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Tentar Novamente',
                    style: TextStyle(color: this.fontColor),
                  ),
                ),
              ),
              ...((this.context != null)
                  ? [
                      SizedBox(height: 20),
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed('login');
                          LoginBloc().dispatch(LoggedOut());
                        },
                        padding: EdgeInsets.all(20),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 2, color: this.fontColor),
                          borderRadius: BorderRadius.all(
                            Radius.circular(45),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Sair',
                            style: TextStyle(color: this.fontColor),
                          ),
                        ),
                      )
                    ]
                  : [])
            ],
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
      );
}

Widget divisionLine(context, {int greyLevel = 200, double lineHeight = 1}) =>
    Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Colors.grey[greyLevel],
          ),
        ),
        width: MediaQuery.of(context).size.width,
        height: lineHeight);
