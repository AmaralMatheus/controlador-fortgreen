import 'package:controlador/colors.dart';
import 'package:controlador/models/notification.dart';
import 'package:controlador/widgets/basic_widgets.dart';
import 'package:controlador/widgets/notification/notification_bloc/notification_bloc.dart';
import 'package:controlador/widgets/notification/notification_bloc/notification_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'notification_bloc/notification_event.dart';
import 'notification_item.dart';

class Notifications extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NotificationsState();
}

class NotificationsState extends State<Notifications> {
  List<NotificationModel> _unreadItems;
  List<NotificationModel> _readItems;
  List<Widget> _bodyWidgets;
  NotificationBloc _notificationBloc;

  NotificationsState();

  @override
  void initState() {
    super.initState();
    _readItems = [];
    _unreadItems = [];
    this._bodyWidgets = [];
  }

  @override
  Widget build(BuildContext context) {
    this._notificationBloc = BlocProvider.of<NotificationBloc>(context);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarBrightness:
            Brightness.light
        ));

    return BlocBuilder<NotificationBloc, NotificationState>(
      bloc: this._notificationBloc,
      builder: (context, state) {
        if (state is UnloadedNotificationsState) {
          this._notificationBloc.dispatch(GetNotificationsEvent());
        }

        if (state is LoadingNotificationsState) {
          this._bodyWidgets = [
            Center(
              child: Container(
                padding: EdgeInsets.only(top: 40),
                child: Text("Buscando notificações..."),
              ),
            )
          ];
        }

        if (state is LoadedNotificationsState) {
          this._readItems = state.readNotifications;
          this._unreadItems = state.unreadNotifications;
          this._bodyWidgets = _getBodyWidgets();
        }

        if (state is NotificationFailure) {
          this._bodyWidgets = [
            Center(
              child: Container(
                padding: EdgeInsets.only(top: 40),
                child: Text("Erro ao buscar notificações!"),
              ),
            )
          ];
        }

        return _mainWidget();
      },
    );
  }

  Widget _mainWidget() => SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Drawer(
          elevation: 1,
          child: Container(
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.0375),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                  height: MediaQuery.of(context).size.width * 0.3,
                  decoration: _background(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _closeButton(),
                      _notificationsTitle(),
                    ],
                  ),
                ),
                ...this._bodyWidgets
              ],
            ),
          ),
        ),
      );

  List<Widget> _getBodyWidgets() => [
        if (this._unreadItems.isNotEmpty) ...[
          Container(
              margin: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: MediaQuery.of(context).size.width * 0.075),
              child: Text('Novas',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Palette.greenDark))),
          NotificationItem(items: this._unreadItems),
          SizedBox(
            height: 10,
          ),
          divisionLine(context, greyLevel: 200, lineHeight: 2),
        ],
        if (this._readItems.isNotEmpty)
          NotificationItem(
            items: this._readItems,
            opened: true,
          )
      ];

  Widget _closeButton() => Container(
      alignment: Alignment.topRight,
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.0375),
      child: IconButton(
          padding: EdgeInsets.zero,
          icon: Icon(Icons.close, color: Colors.grey),
          onPressed: () {
            Navigator.pop(context);
          }));

  Widget _notificationsTitle() => Container(
        alignment: Alignment.bottomLeft,
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.width * 0.01),
        margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.075),
        child: Text(
          'Notificações',
          style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.08,
              fontWeight: FontWeight.bold,
              color: Palette.greenDark),
        ),
      );

  BoxDecoration _background() => BoxDecoration(
        image: DecorationImage(
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.375), BlendMode.dstATop),
            image: AssetImage('assets/png/background-light.png'),
            fit: BoxFit.fitWidth,
            alignment: Alignment.topCenter),
      );
}
