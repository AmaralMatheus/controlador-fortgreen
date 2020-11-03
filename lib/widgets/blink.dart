import 'dart:async';

import 'package:controlador/screens/lights/bloc/bloc.dart';
import 'package:controlador/screens/lights/bloc/event.dart';
import 'package:flutter/material.dart';
import 'package:controlador/globals.dart' as globals;

class BlinkWidget extends StatefulWidget {
  final Widget child;
  LightBloc bloc;
  BlinkWidget({this.child, this.bloc});
  @override
  BlinkingTextState createState() => BlinkingTextState(bloc: this.bloc);
}

class BlinkingTextState extends State<BlinkWidget> {
  bool _show = true;
  LightBloc bloc;
  Timer _timer;
  BlinkingTextState({this.bloc});

  @override
  void initState() {
    _timer = Timer.periodic(Duration(milliseconds: 700), (_) {
      setState(() {
        _show = !_show;
        this.bloc.dispatch(_show ? Blink() : DontBlink());
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Container(
    child: _show
      ? widget.child
      : Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          color: _show ? Colors.transparent : Colors.yellow,
        ),
        child: widget.child,  
      ));

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}