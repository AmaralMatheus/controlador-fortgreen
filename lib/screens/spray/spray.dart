import 'package:controlador/resources/mqtt.dart';
import 'package:controlador/screens/lights/bloc/state.dart';
import 'package:controlador/widgets/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:controlador/globals.dart' as globals;

class SprayScreen extends StatefulWidget {
  final BLoC bloc;
  SprayScreen({this.bloc});
  _SprayScreenState createState() => _SprayScreenState();
}

class _SprayScreenState extends State<SprayScreen> {
  List<bool> sprays = [
    false, false, false, false, false, false, false, false, false, false, false, false
  ];
  final BLoC bloc = globals.bloc;
  bool tjet = false;

  Mqtt mqttClientWrapper = Mqtt();

  Widget build(BuildContext context) => BlocBuilder(
    bloc: this.bloc,
    builder: (context, state) {
      switch(state.message) {
        case '201':
          sprays[0] = true;
          break;
        case '202':
          sprays[1] = true;
          break;
        case '203':
          sprays[2] = true;
          break;
        case '204':
          sprays[3] = true;
          break;
        case '205':
          sprays[4] = true;
          break;
        case '206':
          sprays[5] = true;
          break;
        case '207':
          sprays[6] = true;
          break;
        case '208':
          sprays[7] = true;
          break;
        case '209':
          sprays[8] = true;
          break;
        case '210':
          sprays[9] = true;
          break;
        case '211':
          sprays[10] = true;
          break;
        case '212':
          sprays[11] = true;
          break;
        case '251':
          sprays[0] = false;
          break;
        case '252':
          sprays[1] = false;
          break;
        case '253':
          sprays[2] = false;
          break;
        case '254':
          sprays[3] = false;
          break;
        case '255':
          sprays[4] = false;
          break;
        case '256':
          sprays[5] = false;
          break;
        case '257':
          sprays[6] = false;
          break;
        case '258':
          sprays[7] = false;
          break;
        case '259':
          sprays[8] = false;
          break;
        case '260':
          sprays[9] = false;
          break;
        case '261':
          sprays[10] = false;
          break;
        case '262':
          sprays[11] = false;
          break;
        case '299':
          tjet = false;
          break;
        case '298':
          tjet = true;
          break;
      }

      return Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: 100,
            margin: EdgeInsets.all(50),
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: state is !Blinking ? Colors.yellow : Colors.white
              ),
              borderRadius: BorderRadius.all(Radius.circular(50))
            ),
            child: Container(
              margin: EdgeInsets.all(25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width/2.75,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(50))
                    ),
                  ),
                  this.tjet ? _tjetButton(299) : _tjetButton(298),
                  Container(
                    width: MediaQuery.of(context).size.width/2.75,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(50))
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _sprayButton(10),
                    _sprayButton(8),
                    _sprayButton(6),
                    _sprayButton(4),
                    _sprayButton(2),
                    _sprayButton(0),
                  ]
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _sprayButton(11),
                    _sprayButton(9),
                    _sprayButton(7),
                    _sprayButton(5),
                    _sprayButton(3),
                    _sprayButton(1),
                  ]
                )
              ],
            ),
          )
        ],
      );
    }
  );

  Widget _sprayButton(int index) => FloatingActionButton(
    backgroundColor: this.sprays[index] ? Colors.green : Colors.grey,
    heroTag: 'spray'+index.toString(),
    onPressed: () {
      setState(() {
        if(!tjet) {
          switch (index) {
            case 0:
              mqttClientWrapper.connect(201, 'A', this.bloc);
              break;
            case 1:
              mqttClientWrapper.connect(202, 'A', this.bloc);
              break;
            case 2:
              mqttClientWrapper.connect(203, 'A', this.bloc);
              break;
            case 3:
              mqttClientWrapper.connect(204, 'A', this.bloc);
              break;
            case 4:
              mqttClientWrapper.connect(205, 'A', this.bloc);
              break;
            case 5:
              mqttClientWrapper.connect(206, 'A', this.bloc);
              break;
            case 6:
              mqttClientWrapper.connect(207, 'A', this.bloc);
              break;
            case 7:
              mqttClientWrapper.connect(208, 'A', this.bloc);
              break;
            case 8:
              mqttClientWrapper.connect(209, 'A', this.bloc);
              break;
            case 9:
              mqttClientWrapper.connect(210, 'A', this.bloc);
              break;
            case 10:
              mqttClientWrapper.connect(211, 'A', this.bloc);
              break;
            case 11:
              mqttClientWrapper.connect(212, 'A', this.bloc);
              break;
          }
        }
      });
    },
    child: sprays[index] && !tjet ? Icon(Icons.blur_on) : Icon(Icons.blur_off, color: Colors.white),
  );

  Widget _tjetButton(int index) => FloatingActionButton(
    backgroundColor: this.tjet ? Colors.green : Colors.grey,
    heroTag: 'spray'+index.toString(),
    onPressed: () {
      setState(() {
        switch (index) {
          case 299:
            mqttClientWrapper.connect(299, 'A', this.bloc);
            break;
          case 298:
            mqttClientWrapper.connect(298, 'A', this.bloc);
            break;
        }
      });
    },
    child: Text('T-Jet', style: TextStyle(color: Colors.white)),
  );
}