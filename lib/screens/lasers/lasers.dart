import 'package:controlador/resources/mqtt.dart';
import 'package:controlador/widgets/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:controlador/globals.dart' as globals;

class LaserScreen extends StatefulWidget {
  final BLoC bloc;
  LaserScreen({this.bloc});

  _LaserScreenState createState() => _LaserScreenState();
}

class _LaserScreenState extends State<LaserScreen> {
  Mqtt mqttClientWrapper = Mqtt();
  final BLoC bloc = globals.bloc;
  List<bool> pumps = [false, false, false, false, false, false, false, false];

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) => BlocBuilder(
    bloc: this.bloc,
    builder: (context, state) { 
      switch(state.message) {
        case '65':
          pumps[0] = true;
          break;
        case '66':
          pumps[1] = true;
          break;
        case '67':
          pumps[2] = true;
          break;
        case '68':
          pumps[3] = true;
          break;
        case '69':
          pumps[4] = true;
          break;
        case '70':
          pumps[5] = true;
          break;
        case '71':
          pumps[6] = true;
          break;
        case '72':
          pumps[7] = true;
          break;
        case '85':
          pumps[0] = false;
          break;
        case '86':
          pumps[1] = false;
          break;
        case '87':
          pumps[2] = false;
          break;
        case '88':
          pumps[3] = false;
          break;
        case '89':
          pumps[4] = false;
          break;
        case '90':
          pumps[5] = false;
          break;
        case '91':
          pumps[6] = false;
          break;
        case '92':
          pumps[7] = false;
          break;
      }

      return Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 95,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _pump(0, 'F. Baixo'),
              _pump(1, 'F. Alto'),
              _pump(2, 'L. Baixo'),
              _pump(3, 'L. Alto'),
              _pump(4, 'V. E'),
              _pump(6, 'V. D'),
              _pump(5, '360'),
              _pump(7, 'Welcome'),
            ],
          )
        )
      );
    }
  );

  Widget _pump(int index, String label) => Column(
    children: [
      Container(
        padding: EdgeInsets.zero,
        child: Text(label, style: TextStyle(color: Colors.white)),
      ),
      FloatingActionButton(
        heroTag: (index+10).toString(),
        backgroundColor: pumps[index] ? Colors.green : Colors.grey,
        mini: false,
        onPressed: () {
          setState(() {
            switch (index) {
              case 0:
                mqttClientWrapper.connect(65, 'A', this.bloc);
                break;
              case 1:
                mqttClientWrapper.connect(66, 'A', this.bloc);
                break;
              case 2:
                mqttClientWrapper.connect(67, 'A', this.bloc);
                break;
              case 3:
                mqttClientWrapper.connect(68, 'A', this.bloc);
                break;
              case 4:
                mqttClientWrapper.connect(69, 'A', this.bloc);
                break;
              case 5:
                mqttClientWrapper.connect(70, 'A', this.bloc);
                break;
              case 6:
                mqttClientWrapper.connect(71, 'A', this.bloc);
                break;
              case 7:
                mqttClientWrapper.connect(72, 'A', this.bloc);
                break;
            }
          });
        },
        child: Icon(Icons.line_weight),
      )
    ]
  );
}