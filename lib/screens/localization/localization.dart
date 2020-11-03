import 'dart:async';

import 'package:controlador/resources/mqtt.dart';
import 'package:controlador/screens/localization/bloc/bloc.dart';
import 'package:controlador/widgets/bloc/bloc.dart';
import 'package:controlador/widgets/bloc/lbloc.dart';
import 'package:controlador/widgets/bloc/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matrix4_transform/matrix4_transform.dart';

import 'package:controlador/globals.dart' as globals;

class LocalizationScreen extends StatefulWidget {
  final LocalizationBLoC bloc;

  LocalizationScreen({this.bloc});
  _LocalizationScreenState createState() => _LocalizationScreenState();
}

class _LocalizationScreenState extends State<LocalizationScreen> {
  double width = 500, height = 100, degrees = 90, speed = 1, realSpeed = 1, edgeHeight = 0, edgeWidth = 0, zCoord = 0,
  xRestriction0 = 0, xRestriction1 = 100, yRestriction0 = 0, yRestriction1 = 100, eixox = 0, eixoy = 0, z = 0, rotation = 0;
  double x = 0, y = 0;
  String auto = 'asas', _movimentoLabel = 'Automático', _movimento = '301';
  int quantityProgrammed = 0, quantityRealized = 0;
  Mqtt mqttClientWrapper = Mqtt();
  final BLoC bloc = globals.bloc;
  final LocalizationBLoC lbloc = globals.lbloc;

  bool up = false,
    down = false,
    above = false,
    below = false,
    left = false,
    right = false,
    zero = false,
    paused = false,
    hundredeighteen = false,
    nineteen = false,
    automatic = false;

  @override
  void initState() {
    super.initState();
  }
    
  Widget build(BuildContext context) => BlocBuilder(
    bloc: this.lbloc,
    builder: (context, state) {
      if(state.message.startsWith('X')) this.width = (MediaQuery.of(context).size.width - 100) * (int.parse(state.message.toString().replaceFirst('X', ''))/1000);
      if(state.message.startsWith('X')) this.x = double.parse(state.message.toString().replaceFirst('X', ''))/10;
      if(state.message.startsWith('Y')) this.height = 150 * ((int.parse(state.message.toString().replaceFirst('Y', ''))/1000));
      if(state.message.startsWith('Y')) this.y = double.parse(state.message.toString().replaceFirst('Y', ''))/10;
      if(state.message.startsWith('Z')) this.zCoord = int.parse(state.message.toString().replaceFirst('Z', ''))/10;
      if(state.message.startsWith('R')) this.degrees = double.parse(state.message.toString().replaceFirst('R', ''))*(-1);
      if(state.message.startsWith('S')) this.speed = double.parse(state.message.toString().replaceFirst('S', ''));
      if(state.message.startsWith('V')) this.realSpeed = double.parse(state.message.toString().replaceFirst('V', ''));
      if(state.message.startsWith('B')) this.quantityProgrammed = int.parse(state.message.toString().replaceFirst('B', ''));
      if(state.message.startsWith('A')) this.quantityRealized = int.parse(state.message.toString().replaceFirst('A', ''));
      if(state.message.startsWith('C')) this.xRestriction0 = double.parse(state.message.toString().replaceFirst('C', ''))/10;
      if(state.message.startsWith('D')) this.xRestriction1 = double.parse(state.message.toString().replaceFirst('D', ''))/10;
      if(state.message.startsWith('E')) this.yRestriction0 = double.parse(state.message.toString().replaceFirst('E', ''))/10;
      if(state.message.startsWith('F')) this.yRestriction1 = double.parse(state.message.toString().replaceFirst('F', ''))/10;

      return BlocBuilder(
        bloc: this.bloc,
        builder: (context, state) {
          switch (state.message) {
            case '395':
              automatic = true;
              paused = true;
              break;
            case '396':
              automatic = false;
              paused = false;
              break;
            case '397':
              paused = true;
              break;
          }
          switch(state.message) {
            case '0':
              left = false;
              right = false;
              break;
            case '1':
              up = false;
              down = false;
              left = false;
              right = true;
              break;
            case '2':
              up = false;
              down = false;
              left = true;
              right = false;
              break;
            case '10':
              up = false;
              down = false;
              break;
            case '11':
              up = true;
              down = false;
              left = false;
              right = false;
              break;
            case '12':
              up = false;
              down = true;
              left = false;
              right = false;
              break;
            case '21':
              above = true;
              below = false;
              break;
            case '22':
              above = false;
              below = true;
              break;
            case '20':
              above = false;
              below = false;
              break;
            case '30':
              zero = true;
              hundredeighteen = false;
              nineteen = false;
              break;
            case '31':
              zero = false;
              hundredeighteen = false;
              nineteen = true;
              break;
            case '32':
              zero = false;
              hundredeighteen = true;
              nineteen = false;
              break;
          }
          return Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width - width - 100,
                  left: width,
                  bottom: 250 - (height) - 100,
                  top: height
                ),
                height: 250,
                color: Color.fromRGBO(10, 10, 10, 1),
                child: Transform(
                  alignment: FractionalOffset.center,
                  transform: Matrix4Transform().rotateDegrees(this.degrees).matrix4,
                  child: GestureDetector(
                    onTap: () => mqttClientWrapper.connect(9, 'A', this.bloc),
                    onLongPress: () => mqttClientWrapper.connect(8, 'A', this.bloc),
                    child: Container(
                    width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/png/untitled (4).png')
                        )
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 35,
                            width: MediaQuery.of(context).size.width/1.05,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                            child: Slider(
                              value: this.realSpeed,
                              max: 100,
                              min: 0,
                              onChanged: (value) {},
                              activeColor: Colors.red,
                              inactiveColor: Colors.white,
                            )
                          ), 
                          Text('  ' + (realSpeed/10).toString(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
                        ]
                      ),  
                      SizedBox(height: 0,), 
                      Row(
                        children: [
                          Container(
                            height: 35,
                            width: MediaQuery.of(context).size.width/1.05,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                            child: Slider(
                              value: this.speed,
                              max: 100,
                              min: 0,
                              onChanged: (value) {},
                              onChangeEnd: (value) {
                                print(value);
                                mqttClientWrapper.connect('S'+value.round().toString().replaceAll('.0', ''), 'B', this.bloc);
                              },
                              activeColor: Colors.white,
                              inactiveColor: Colors.white,
                            )
                          ), 
                          Text('  '+(speed/10).toString(), style: TextStyle(color: Colors.white))
                        ]
                      ),
                    ]
                  ), 
                )
              ),
              SizedBox(height: 25,), 
              Container(
                width: MediaQuery.of(context).size.width * 0.95,
                padding: EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(width:1, color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: this.zero ? Color.fromARGB(255, 120, 120, 120) : Colors.transparent,
                      ),
                      child: FlatButton(
                        padding: EdgeInsets.zero,
                        child: Text('0', style: TextStyle(color: this.zero ? Colors.white : Colors.white)),
                        onPressed: () => mqttClientWrapper.connect(30, 'A', this.bloc)
                      ),
                    ),
                    SizedBox(width: 5),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(width:1, color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: this.nineteen ? Color.fromARGB(255, 120, 120, 120) : Colors.transparent,
                      ),
                      child: FlatButton(
                        padding: EdgeInsets.zero,
                        child: Text('90', style: TextStyle(color: this.nineteen ? Colors.white : Colors.white)),
                        onPressed: () => mqttClientWrapper.connect(31, 'A', this.bloc)
                      ),
                    ),
                    SizedBox(width: 5),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(width:1, color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: this.hundredeighteen ? Color.fromARGB(255, 120, 120, 120) : Colors.transparent,
                      ),
                      child: FlatButton(
                        padding: EdgeInsets.zero,
                        child: Text('180', style: TextStyle(color: this.hundredeighteen ? Colors.white : Colors.white)),
                        onPressed: () => mqttClientWrapper.connect(32, 'A', this.bloc)
                      ),
                    ),
                    SizedBox(width: 5),
                    Container(
                      margin: EdgeInsets.only(right: 5),
                      width: 50,
                      decoration: BoxDecoration(
                        border: Border.all(width:1, color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Colors.transparent,
                      ),
                      child: FlatButton(
                        padding: EdgeInsets.zero,
                        child: Text('-', style: TextStyle(color: Colors.white, fontSize: 25)),
                        onPressed: () => mqttClientWrapper.connect('398', 'A', this.bloc)
                      ),
                    ),
                    Text(' '+this.quantityRealized.toString()+'/'+this.quantityProgrammed.toString()+' ', style: TextStyle(color: Colors.white)),
                    Container(
                      width: 50,
                      margin: EdgeInsets.only(right: 5),
                      decoration: BoxDecoration(
                        border: Border.all(width:1, color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Colors.transparent,
                      ),
                      child: FlatButton(
                        padding: EdgeInsets.zero,
                        child: Text('+', style: TextStyle(color: Colors.white, fontSize: 25)),
                        onPressed: () => mqttClientWrapper.connect('399', 'A', this.bloc)
                      ),
                    ),
                    SizedBox(width:25),
                    new DropdownButton<String>(
                      hint: Text('Movimento automático', style: TextStyle(color: Colors.white)),
                      style: TextStyle(color: Colors.black),
                      value: this._movimentoLabel,
                      items: <String>['Automático', 'Demonstração 1', 'Demonstração 2', 'Pos. descanso', 'Pos. central', 'Pos. Vidro 1', 'Pos. Vidro 2', 'Pos. Laser 1', 'Pos. Laser 2', 'Pos. Laser 3', 'Movimento 1', 'Movimento 2', 'Movimento 3', 'Movimento 4'].map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: Container(
                            padding: EdgeInsets.zero,
                            color: Colors.black,
                            child: Text(value, style: TextStyle(color: Colors.white)),
                          )
                        );
                      }).toList(),
                      underline: Container(),
                      onChanged: (value) {
                        setState(() {
                          if (!this.automatic) {
                            switch (value) {
                              case 'Automático': this._movimento = '301'; break;
                              case 'Pos. descanso': this._movimento = '302'; break;
                              case 'Pos. central': this._movimento = '303'; break;
                              case 'Pos. Vidro 1': this._movimento = '304';  break;
                              case 'Pos. Vidro 2': this._movimento = '305';  break;
                              case 'Movimento 1': this._movimento = '306';  break;
                              case 'Movimento 2': this._movimento = '307';  break;
                              case 'Movimento 3': this._movimento = '308';  break;
                              case 'Movimento 4': this._movimento = '309';  break;
                              case 'Demonstração 1': this._movimento = '310';  break;
                              case 'Demonstração 2': this._movimento = '311';  break;
                              case 'Pos. Laser 1': this._movimento = '312';  break;
                              case 'Pos. Laser 2': this._movimento = '313';  break;
                              case 'Pos. Laser 3': this._movimento = '314';  break;
                            }
                            this._movimentoLabel = value;
                          }
                        });
                      },
                    ),
                    SizedBox(width:5),
                    Container(
                      margin: EdgeInsets.only(right: 5),
                      decoration: BoxDecoration(
                        border: Border.all(width:1, color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: this.automatic ? Colors.white : Colors.green
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(this.automatic && this.paused ? Icons.pause : Icons.play_arrow),
                        onPressed: () => mqttClientWrapper.connect(this.automatic && this.paused ? '395' : this._movimento , 'A', this.bloc)
                      ),
                    ),
                    SizedBox(width:5),
                    Container(
                      margin: EdgeInsets.only(right: 5),
                      decoration: BoxDecoration(
                        border: Border.all(width:1, color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: this.automatic || this.paused ? Colors.red : Colors.grey
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(Icons.stop),
                        onPressed: () => mqttClientWrapper.connect('396' , 'A', this.bloc)
                      ),
                    ),
                  ],
                )
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(width:1, color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: this.left ? Colors.white : Colors.transparent,
                      ),
                      child: GestureDetector(
                        child: Container(
                          width: 100,
                          height: 100,
                          child: Icon(Icons.arrow_back, color: this.left ? Colors.green : Colors.white, size: 75),
                        ),
                        onTapDown: (value) => mqttClientWrapper.connect(1, 'A', this.bloc),
                        onTapCancel: () => mqttClientWrapper.connect(0, 'A', this.bloc),
                        onTapUp: (value) => mqttClientWrapper.connect(0, 'A', this.bloc),
                      ),
                    ),
                    Column(
                      children: [
                        Text(xRestriction1.toString()+'%', style: TextStyle(color: Colors.red)),
                        Text(x.toString()+'%', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        Text(xRestriction0.toString()+'%', style: TextStyle(color: Colors.red)),
                      ]
                    ),
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(width:1, color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: this.right ? Colors.white : Colors.transparent,
                      ),
                      child: GestureDetector(
                        child: Container(
                          width: 100,
                          height: 100,
                          child: Icon(Icons.arrow_forward, color: this.right ? Colors.green : Colors.white, size: 75),
                        ),
                        onTapDown: (value) => mqttClientWrapper.connect(2, 'A', this.bloc),
                        onTapUp: (value) => mqttClientWrapper.connect(0, 'A', this.bloc),
                        onTapCancel: () => mqttClientWrapper.connect(0, 'A', this.bloc),
                      ),
                    ),
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(width:1, color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: this.up ? Colors.white : Colors.transparent,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.arrow_upward, color: this.up ? Colors.green : Colors.white, size: 75),
                        onPressed: () => mqttClientWrapper.connect(!this.up ? 11 : 10, 'A', this.bloc)
                      ),
                    ),
                    Column(
                      children: [
                        Text(yRestriction0.toString()+'%', style: TextStyle(color: Colors.red)),
                        Text(y.toString()+'%', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        Text(yRestriction1.toString()+'%', style: TextStyle(color: Colors.red)),
                      ]
                    ),
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(width:1, color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: this.down ? Colors.white : Colors.transparent,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.arrow_downward, color: this.down ? Colors.green : Colors.white, size: 75),
                        onPressed: () => mqttClientWrapper.connect(!this.down ? 12 : 10, 'A', this.bloc)
                      ),
                    ),
                    Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.only(right: 5),
                      decoration: BoxDecoration(
                        border: Border.all(width:1, color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: this.above ? Colors.white : Colors.transparent,
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(Icons.call_received, color: this.above ? Colors.green : Colors.white, size: 75),
                        onPressed: () => mqttClientWrapper.connect(!this.above ? 21 : 20, 'A', this.bloc)
                      ),
                    ),
                    Text(this.zCoord.toString()+'% ', style: TextStyle(color: Colors.white)),
                    Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.only(right: 5),
                      decoration: BoxDecoration(
                        border: Border.all(width:1, color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: this.below ? Colors.white : Colors.transparent,
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(Icons.call_made, color: this.below ? Colors.green : Colors.white, size: 75),
                        onPressed: () => mqttClientWrapper.connect(!this.below ? 22 : 20, 'A', this.bloc)
                      ),
                    ),
                  ]
                )
              ),
            ]
          );
        }
      );
    }
  );
}