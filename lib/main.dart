import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:bloc/bloc.dart';
import 'package:controlador/screens/home/home.dart';
import 'package:mqtt_client/mqtt_client.dart';

import 'resources/simple_bloc_delegate.dart';
import 'screens/login/bloc/login_bloc.dart';
import 'screens/login/login.dart';
import 'screens/register/register.dart';
import 'screens/splash/splash.dart';
import 'widgets/notification/notification_bloc/notification_bloc.dart';
import 'widgets/transition.dart';
import 'package:controlador/globals.dart' as globals;
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  BlocSupervisor.delegate = SimpleBlocDelegate();
  Intl.defaultLocale = 'pt_BR';
  // await initializeDateFormatting('pt_BR');

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

  runApp(MyApp());
}

class Wrapper extends StatelessWidget {
  final Widget child;

  Wrapper(this.child);

  Timer timer;

  Widget _sizeBuilder(BuildContext context, BoxConstraints constraints) =>
      this.child;

  @override
  Widget build(BuildContext context) => BlocListener(
    bloc: globals.bloc,
    listener: (context, state) {
      if(globals.client.connectionStatus.state != MqttConnectionState.connected) {
        globals.connect();
      }
    },
    child: LayoutBuilder(
        builder: this._sizeBuilder,
      )
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _routes = <String, WidgetBuilder>{
    'splash': (context) => Wrapper(SplashScreen()),
    'login': (context) => Wrapper(LoginScreen()),
    'register': (context) => Wrapper(RegisterScreen()),
    'home' : (context) => Wrapper(HomeScreen())
  };

  // final _analytics = FirebaseAnalytics();

  LoginBloc _loginBloc;
  NotificationBloc _notificationBloc;

  @override
  void initState() {
    super.initState();
    globals.connect();
    this._loginBloc = LoginBloc();
    this._notificationBloc = NotificationBloc();

    Timer.periodic(Duration(seconds: 1), (Timer t) {
      print('cleaning cache');
      _deleteCacheDir();
    });
  }

  @override
  void dispose() {
    super.dispose();
    this._loginBloc.dispose();
    this._notificationBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lembrey',
      theme: ThemeData(fontFamily: 'Gilroy', canvasColor: Colors.white),
      initialRoute: 'splash',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) => CustomTransition(
        settings: settings,
        builder: this._routes[settings.name],
      ),
      // navigatorObservers: [
      //   FirebaseAnalyticsObserver(
      //     analytics: this._analytics,
      //     onError: (error) => print('$error'),
      //   ),
      // ],
    );
  }

  Future<void> _deleteCacheDir() async {
    final cacheDir = await getTemporaryDirectory();

    if (cacheDir.existsSync()) {
      cacheDir.deleteSync(recursive: true);
    }
  }
}
