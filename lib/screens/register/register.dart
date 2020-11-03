import 'package:flutter/material.dart';
import '../../colors.dart';
import 'widgets/input.dart';

class RegisterScreen extends StatefulWidget {
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String nameError = '', birthError = '', emailError = '', passwordError = '';

  Widget build(BuildContext context) => Scaffold(
    body: GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.height,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            alignment: Alignment.topCenter,
            image: AssetImage('assets/png/background/shapes-background.png'),
            fit: BoxFit.fitWidth
          )
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 20),
                child: FloatingActionButton(
                  focusElevation: 0,
                  hoverElevation: 0,
                  highlightElevation: 0,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  child: Icon(Icons.arrow_back_ios,
                      color: Colors.white),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: 75,
                  height: 75,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Palette.purple,
                    border: Border.all(width: 6, color: Colors.white)
                  ),
                  child: Icon(Icons.person, color: Colors.white, size: 50)
                )
              ),
              Text(
                'CRIE O PERFIL',
                style: TextStyle(
                  fontSize: 22.5,
                  color: Colors.grey
                ),
              ),
              Input(
                label: 'Nome',
                error: nameError,
                controller: TextEditingController(),
                suffix: Icon(Icons.person_outline, color: Colors.grey),
              ),
              Input(
                label: 'Data de nascimento',
                error: birthError,
                controller: TextEditingController(),
                suffix: Icon(Icons.card_giftcard, color: Colors.grey),
              ),
              Input(
                label: 'E-mail',
                error: emailError,
                controller: TextEditingController(),
                suffix: Icon(Icons.mail_outline, color: Colors.grey),
              ),
              Input(
                label: 'Senha',
                error: passwordError,
                controller: TextEditingController(),
                suffix: Icon(Icons.lock_outline, color: Colors.grey),
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.07),
                child: Center(
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
                    color: Palette.purple,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(45)),
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width -
                          (MediaQuery.of(context).size.width * 0.05),
                      height: MediaQuery.of(context).size.height * 0.075,
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        'Criar conta',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    onPressed: () =>
                        Navigator.of(context).pushNamed('register'),
                  ),
                ),
              )
            ],
          ),
        )
      )
    )
  );
}