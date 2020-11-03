import 'package:controlador/resources/mqtt.dart';
import 'package:flutter/material.dart';
import 'package:controlador/widgets/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:controlador/globals.dart' as globals;

class PumpScreen extends StatefulWidget {
  final BLoC bloc;
  PumpScreen({this.bloc});
  _PumpScreenState createState() => _PumpScreenState();
}

class _PumpScreenState extends State<PumpScreen>  with TickerProviderStateMixin {
  List<bool> pumps = [false, false, false, false];
  List<AnimationController> _controller = [];
  Mqtt mqttClientWrapper = Mqtt();
  final BLoC bloc = globals.bloc;

  @override
  void initState() {
    for(int count = 0; count < 4; count++) {
      _controller.add(
        AnimationController(
          duration: const Duration(milliseconds: 500),
          vsync: this,
        )
      );
    }
    super.initState();
  }

  Widget build(BuildContext context) => BlocBuilder(
    bloc: this.bloc,
    builder: (context, state) {
      switch(state.message) {
        case '41':
          pumps[0] = true;
          _controller[0].repeat();
          break;
        case '42':
          pumps[1] = true;
          _controller[1].repeat();
          break;
        case '43':
          pumps[2] = true;
          _controller[2].repeat();
          break;
        case '44':
          pumps[3] = true;
          _controller[3].repeat();
          break;
        case '51':
          pumps[0] = false;
          _controller[0].reset();
          break;
        case '52':
          pumps[1] = false;
          _controller[1].reset();
          break;
        case '53':
          pumps[2] = false;
          _controller[2].reset();
          break;
        case '54':
          pumps[3] = false;
          _controller[3].reset();
          break;
      }

      return Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 30),
                child: _pump(0, 'Automática')
              ),
              _pump(1, 'Manual'),
              _pump(2, 'Automática'),
              Padding(
                padding: EdgeInsets.only(right: 30),
                child:_pump(3, 'Manual'),
              )
            ],
          )
        )
      );
    }
  );

  Widget _pump(int index, String label) => Column(
    children: [
      Container(
        padding: EdgeInsets.only(bottom: 5),
        child: Text(label, style: TextStyle(color: Colors.white)),
      ),
      FloatingActionButton(
        heroTag: index.toString(),
        backgroundColor: pumps[index] ? null: Colors.grey,
        onPressed: () {
          setState(() {
            switch (index) {
              case 0:
                mqttClientWrapper.connect(41, 'A', this.bloc);
                break;
              case 1:
                mqttClientWrapper.connect(42, 'A', this.bloc);
                break;
              case 2:
                mqttClientWrapper.connect(43, 'A', this.bloc);
                break;
              case 3:
                mqttClientWrapper.connect(44, 'A', this.bloc);
                break;
            }
          });
        },
        child: RotationTransition(
          turns: Tween(begin: 0.0, end: 1.0).animate(_controller[index]),
          child: Icon(Icons.autorenew),
        )
      )
    ]
  );
}