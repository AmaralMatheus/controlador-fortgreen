import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './widgets/form_page.dart';

class LoginScreen extends StatefulWidget {
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginScreen>{
  _LoginPageState();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarBrightness: Brightness.light
    ));
    return LoginForm();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
