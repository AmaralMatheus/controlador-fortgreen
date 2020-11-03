import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:controlador/colors.dart';

class ProfileScreen extends StatefulWidget {
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Widget build(BuildContext context) => Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * 0.2,
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(75)
            ),
            gradient: LinearGradient(
              colors: [
                Palette.purple,
                Colors.white
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.85,0.85],
            )
          ),
          child: Row(
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    width: 75,
                    height: 75,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 2, color: Colors.white),
                      image: DecorationImage(
                        image: AssetImage('assets/png/background/full-background.png'),
                        fit: BoxFit.cover
                      )
                    ),
                  ),
                  Container(
                    width: 25,
                    height: 25,
                    child: FlatButton(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Colors.white,
                          width: 1,
                          style: BorderStyle.solid
                        ), borderRadius: BorderRadius.circular(50)
                      ),
                      color: Colors.lightBlue,
                      onPressed: () {},
                      child: Icon(Icons.edit, color: Colors.white, size: 15,
                      )
                    )
                  )
                ]
              ),
              Container(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'Matheus',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20
                  ),
                ),
              ),
            ]
          )
        ),
        Container(
          padding: EdgeInsets.only(top: 25),
          child: Column(
            children: [
              _renderOption(
                icon: Icons.mail_outline,
                label: 'matheusrockway@gmail.com',
                division: false
              ),
              _renderOption(
                icon: Icons.location_on,
                label: 'Maringá - PR',
                division: true
              ),
              _renderOption(
                icon: Icons.person_outline,
                label: 'Meu Perfil',
                division: true
              ),
              _renderOption(
                icon: Icons.calendar_today,
                label: 'Calendário',
                division: true
              ),
              _renderOption(
                icon: Icons.help_outline,
                label: 'Ajuda',
                division: true
              ),
              _renderOption(
                icon: Icons.settings,
                label: 'Configurações',
                division: true
              ),
              _renderOption(
                icon: Icons.notifications_none,
                label: 'Notificações',
                division: true,
                toggle: true
              ),
              _renderOption(
                icon: Icons.exit_to_app,
                label: 'Sair',
                division: true,
              ),
            ]
          ),
        )
      ],
    ),
  );

  Widget _renderOption({IconData icon, String label, bool division, bool toggle = false}) => FlatButton(
    onPressed: () {},
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width:  0, color: division ? Colors.grey : Colors.white)
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.only(right: 15),
                child: Icon(icon, color: Colors.grey),
              ),
              Text(
                label,
                style: TextStyle(
                  color: Colors.grey
                ),
              )
            ],
          ),
          if (toggle) CupertinoSwitch(
            onChanged: (value) {},
            value: true,
            activeColor: Palette.purple,
          )
        ]
      )
    )
  );
}