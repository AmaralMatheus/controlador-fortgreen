import 'package:controlador/resources/mqtt.dart';
import 'package:controlador/widgets/blink.dart';
import 'package:controlador/widgets/bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:controlador/globals.dart' as globals;
import 'package:flutter_bloc/flutter_bloc.dart';

class LightsScreen extends StatefulWidget {
  final BLoC bloc;
  LightsScreen({this.bloc});
  _LightsScreenState createState() => _LightsScreenState();
}

class _LightsScreenState extends State<LightsScreen> with SingleTickerProviderStateMixin{
  List<bool> lights = [
    false, false, false, false, false
  ];
  final BLoC bloc= globals.bloc;
  String _estrobo = 'Desligado';
  Mqtt mqttClientWrapper = Mqtt();

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) => BlocBuilder(
    bloc: this.bloc,
    builder: (context, state) { 
      switch(state.message) {
        case '61':
          lights[0] = true;
          break;
        case '60':
          lights[1] = true;
          break;
        case '64':
          lights[2] = true;
          break;
        case '63':
          lights[3] = true;
          break;
        case '62':
          lights[4] = true;
          break;
        case '80':
          lights[1] = false;
          break;
        case '81':
          lights[0] = false;
          break;
        case '82':
          lights[4] = false;
          break;
        case '83':
          lights[3] = false;
          break;
        case '84':
          lights[2] = false;
          break;
        case '100':
          this._estrobo = 'Desligado';
          break;
        case '101':
          this._estrobo = 'Estrobo 1';
          break;
        case '102':
          this._estrobo = 'Estrobo 2';
          break;
      }

      return Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Container(
                  //   width: MediaQuery.of(context).size.width/2.5,
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: <Widget>[
                  //       (!globals.blinking ? Container(
                  //         width: 200,
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children:[
                  //             _lightButton(1, 'default', 'Barra'),
                  //             _lightButton(0, 'default', 'Globo'),
                  //           ]
                  //         )
                  //       ) : Container(
                  //         width: 200,
                  //         child: BlinkWidget(
                  //           child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //             children: <Widget>[
                  //               _lightButton(0, 'default', 'Barra manual'),
                  //               _lightButton(1, 'default', 'Barra automática'),
                  //             ],
                  //           )
                  //         )
                  //       )),
                  //       // DropdownButton<String>(
                  //       //   hint: Text('Estrobo', style: TextStyle(color: Colors.white)),
                  //       //   style: TextStyle(color: Colors.black),
                  //       //   value: this._estrobo,
                  //       //   items: <String>['Desligado', 'Estrobo 1', 'Estrobo 2'].map((String value) {
                  //       //     return new DropdownMenuItem<String>(
                  //       //       value: value,
                  //       //       child: Container(
                  //       //         padding: EdgeInsets.zero,
                  //       //         color: Colors.black,
                  //       //         child: Text(value, style: TextStyle(color: Colors.white)),
                  //       //       )
                  //       //     );
                  //       //   }).toList(),
                  //       //   underline: Container(),
                  //       //   onChanged: (value) {
                  //       //     setState(() {
                  //       //       if (value == 'Desligado') mqttClientWrapper.connect(100, 'A', this.bloc);
                  //       //       if (value == 'Estrobo 1') mqttClientWrapper.connect(101, 'A', this.bloc);
                  //       //       if (value == 'Estrobo 2') mqttClientWrapper.connect(102, 'A', this.bloc);
                  //       //     });
                  //       //   }
                  //       // )
                  //     ]
                  //   )
                  // ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        _lightButton(1, 'default', 'Barra', Colors.yellow, Colors.white),
                        _lightButton(4, 'led2', 'Led carrinho', Colors.blue[800], Colors.white),
                        _lightButton(2, 'uv', 'UV', Colors.purple, Colors.white),
                        _lightButton(3, 'led', 'Led', Colors.blue[100], Colors.white),
                        _lightButton(0, 'default', 'Ambiente', Colors.blue[100], Colors.white),
                      ]
                    )
                  ),
                ]
              ),
            ],
          ),
        )
      );
    }
  );

  Widget _lightButton(int index, String type, String label, Color backgroundColor, Color iconColor) => Column(
    children: [
      Container(
        padding: EdgeInsets.only(bottom: 5),
        child: Text(label, style: TextStyle(color: Colors.white)),
      ),
      FloatingActionButton(
        backgroundColor: !lights[index] ? Colors.grey : backgroundColor,
        onPressed: () {
          setState(() {
            switch (index) {
              case 0:
                mqttClientWrapper.connect(61, 'A', this.bloc);
                break;
              case 1:
                mqttClientWrapper.connect(60, 'A', this.bloc);
                break;
              case 2:
                mqttClientWrapper.connect(64, 'A', this.bloc);
                break;
              case 3:
                mqttClientWrapper.connect(63, 'A', this.bloc);
                break;
              case 4:
                mqttClientWrapper.connect(62, 'A', this.bloc);
                break;
            }
          });
        },
        heroTag: 'light'+index.toString(),
        child: lights[index] ? Icon(Icons.brightness_high, color: iconColor) : Icon(Icons.brightness_low, color: Colors.white),
      )
    ]
  );
}