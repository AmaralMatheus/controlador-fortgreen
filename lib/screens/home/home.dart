import 'dart:async';

import 'package:controlador/resources/mqtt.dart';
import 'package:controlador/screens/lasers/lasers.dart';
import 'package:controlador/screens/lights/lights.dart';
import 'package:controlador/screens/localization/localization.dart';
import 'package:controlador/screens/pump/pump.dart';
import 'package:controlador/screens/spray/spray.dart';
import 'package:controlador/widgets/bloc/bloc.dart';
import 'package:controlador/widgets/bloc/lbloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:controlador/globals.dart' as globals;
import 'package:mqtt_client/mqtt_client.dart';

class HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BLoC bloc =  globals.bloc;
  LocalizationBLoC lbloc =  globals.lbloc;
  double speed = 0;
  int percent = 0;
  bool ping = false,
    auto1 = false,
    auto2 = false,
    horizontal = false,
    manual = false,
    initialized = false,
    dialog = false;
  Mqtt mqttClientWrapper = Mqtt();


  initState() {
    super.initState();
    mqttClientWrapper.connect(998, 'A', this.bloc);
    Timer.periodic(Duration(seconds: 3), (Timer t) {
      print('ping');
      globals.sendMessage('A', '1000');
      if(globals.client.connectionStatus.state != MqttConnectionState.connected && initialized) {
        Navigator.of(context).pushReplacementNamed('login');
        setState(() {
          initialized = false;
        });
      }
    });
  }

  Widget build(BuildContext context) => BlocBuilder(
    bloc: this.bloc,
    builder: (context, state) {
      switch(state.message) {
        case '111':
          auto1 = false;
          auto2 = true;
          horizontal = false;
          manual = false;
          break;
        case '110':
          auto1 = true;
          auto2 = false;
          horizontal = false;
          manual = false;
          break;
        case '112':
          auto1 = false;
          auto2 = false;
          horizontal = true;
          manual = false;
          break;
        case '113':
          auto1 = false;
          auto2 = false;
          horizontal = false;
          manual = true;
          break;
        case 'L100': 
            initialized = true;
          break;
      }

      return BlocListener(
        bloc: this.lbloc,
        listener: (context, state) {
          setState(() {
            if(state.message.startsWith('L')) this.percent = int.parse(state.message.toString().replaceFirst('L', ''));

            switch(state.message) {
              case 'L100': 
                  initialized = true;
                break;
            }
            if(state.message.startsWith('W')) this.speed = double.parse(state.message.toString().replaceFirst('W', ''));
          }); 

          if(!dialog && int.parse(state.message.toString()) >= 400 && int.parse(state.message.toString()) <= 499) _showDialog('Falha no eixo X: ' + (int.parse(state.message)-200).toString());
          if(!dialog && int.parse(state.message.toString()) >= 500 && int.parse(state.message.toString()) <= 599) _showDialog('Falha no eixo Y: ' + (int.parse(state.message)-300).toString());
          if(!dialog && int.parse(state.message.toString()) >= 600 && int.parse(state.message.toString()) <= 699) _showDialog('Falha no eixo Z: ' + (int.parse(state.message)-400).toString());
          if(!dialog && int.parse(state.message.toString()) >= 700 && int.parse(state.message.toString()) <= 799) _showDialog('Falha no eixo R: ' + (int.parse(state.message)-500).toString());

        },
        child: this.initialized ? Scaffold(
          backgroundColor: Colors.black,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _title(text: 'Velocidade do ventilador'),
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width/2.6,
                          child: Slider(
                            value: this.speed,
                            max: 100,
                            min: 0,
                            onChanged: (value) {},
                            onChangeEnd: (value) {
                              // speed = value;
                              mqttClientWrapper.connect('W'+value.round().toString(), 'B', this.bloc);
                            },
                            activeColor: Colors.green,
                            inactiveColor: Colors.grey,
                          )
                        ),
                        Text(speed.toInt().toString()+'%', style: TextStyle(color: Colors.white)),
                      ]
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width/2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(width:1, color: Colors.grey),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            color: this.auto1 ? Color.fromARGB(255, 120, 120, 120) : Colors.transparent,
                          ),
                          child: FlatButton(
                            padding: EdgeInsets.zero,
                            child: Text('Auto 1', style: TextStyle(color: this.auto1 ? Colors.white : Colors.white)),
                            onPressed: () => mqttClientWrapper.connect(110, 'A', this.bloc)
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(width:1, color: Colors.grey),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            color: this.auto2 ? Color.fromARGB(255, 120, 120, 120) : Colors.transparent,
                          ),
                          child: FlatButton(
                            padding: EdgeInsets.zero,
                            child: Text('Auto 2', style: TextStyle(color: this.auto2 ? Colors.white : Colors.white)),
                            onPressed: () => mqttClientWrapper.connect(111, 'A', this.bloc)
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(width:1, color: Colors.grey),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            color: this.manual ? Color.fromARGB(255, 120, 120, 120) : Colors.transparent,
                          ),
                          child: FlatButton(
                            padding: EdgeInsets.zero,
                            child: Text('Manual', style: TextStyle(color: this.manual ? Colors.white : Colors.white)),
                            onPressed: () => mqttClientWrapper.connect(113, 'A', this.bloc)
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(width:1, color: Colors.grey),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            color: this.horizontal ? Color.fromARGB(255, 120, 120, 120) : Colors.transparent,
                          ),
                          child: FlatButton(
                            padding: EdgeInsets.zero,
                            child: Text('Horizontal', style: TextStyle(color: this.horizontal ? Colors.white : Colors.white)),
                            onPressed: () => mqttClientWrapper.connect(112, 'A', this.bloc)
                          ),
                        ),
                        ]
                      )
                    )
                  ]
                )
              ),
              _title(text: 'Lasers'),
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.95,
                    height: 110,
                    decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.green),
                      borderRadius: BorderRadius.all(Radius.circular(25))
                    ),
                  ),
                  LaserScreen(bloc: this.bloc),
                ]
              ),
              _title(text: 'Luzes'),
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.95,
                    height: 110,
                    decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.white),
                      borderRadius: BorderRadius.all(Radius.circular(25))
                    ),
                  ),
                  LightsScreen(bloc: this.bloc),
                ]
              ),
              _title(text: 'Bombas'),
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.45,
                          height: 110,
                          decoration: BoxDecoration(
                            border: Border.all(width: 2, color: Colors.red),
                            borderRadius: BorderRadius.all(Radius.circular(25))
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.45,
                          height: 110,
                          decoration: BoxDecoration(
                            border: Border.all(width: 2, color: Colors.blue),
                            borderRadius: BorderRadius.all(Radius.circular(25))
                          ),
                        ),
                      ]
                    ),
                  ),
                  PumpScreen(bloc: this.bloc),
                ]
              ),
              _title(text: 'Pulverizadores'),
              SprayScreen(bloc: this.bloc),
              _title(text: 'Posicionamento'),
              LocalizationScreen(),
            ],
          )
        ) : Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: Container(
              width: MediaQuery.of(context).size.width/2,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width/2,
                    child: Center( child: Text('Carregando: '+percent.toString()+'%', style: TextStyle(color: Colors.white, fontSize: 25)) )
                  ),
                  SizedBox(height: 25),
                  Container(
                    color: Colors.green,
                    width: (MediaQuery.of(context).size.width/2 * (this.percent/100)),
                    height: 5,
                  )
                ]
              )
            )
          )
        )
        // drawer: ProfileScreen(),
      );
    }
  );

  void _showDialog(message) {
    dialog = true;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              message.toString(),
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
                  SizedBox(height: 10),
                  RaisedButton(
                    padding: EdgeInsets.zero,
                    color: Colors.transparent,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.green,
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
                      dialog = false;
                      Navigator.of(context).pop();
                    },
                  )
                ]),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0)),
          );
        });
  }

  Widget _title({String text}) => Container(
    child: Text(text, style: TextStyle(fontSize: 15, color: Colors.white)),
    padding: EdgeInsets.symmetric(vertical: 2.5, horizontal: 50),
  );
}