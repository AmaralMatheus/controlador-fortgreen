import 'package:controlador/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'notification/notification_bloc/notification_bloc.dart';
import 'notification/notification_bloc/notification_event.dart';
import 'notification/notification_bloc/notification_state.dart';

class TopBar extends StatefulWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final String route;
  final int products;

  TopBar({this.scaffoldKey, this.route, this.products = 0});

  _TopBarState createState() => _TopBarState(
    scaffoldKey: this.scaffoldKey,
    route: this.route,
    products: this.products
  );

  @override
  Size get preferredSize => Size.fromHeight(55);
}

class _TopBarState extends State<TopBar> {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final String route;
  int products;
  int unreadNotificationsCount = 0;

  _TopBarState({this.scaffoldKey, this.route, this.products});

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<NotificationBloc, NotificationState>(
        bloc: BlocProvider.of<NotificationBloc>(context),
        builder: (context, state) {
          if (state is UnloadedNotificationsState) {
            BlocProvider.of<NotificationBloc>(context)
                .dispatch(GetNotificationsEvent());
          }

          if (state is LoadedNotificationsState) {
            this.unreadNotificationsCount = state.unreadNotifications.length;
          }

        return AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          brightness: Brightness.light,
          leading: route != 'sell' ? this.scaffoldKey == null || this.route == 'shopping' ? 
            _backButton(context, route) : 
            _drawerButton(scaffoldKey, products, context) : null,
          title: Center(
            child: this.route == 'service' || this.route == 'sell' ? 
            _title(context, route) : 
            _logo(context)
          ),
          actions: [
            _notifications(context)
          ],
        );
      },
    );

  Widget _drawerButton(scaffoldKey, cartItems, context) => Container(
    margin: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.0375),
    child: FloatingActionButton(
      backgroundColor: Colors.transparent,
      focusElevation: 0,
      hoverElevation: 0,
      highlightElevation: 0,
      elevation: 0,
      child: Stack(
        alignment: cartItems > 0 ? Alignment.topRight : Alignment.center,
        children: [
          Icon(
            cartItems > 0 ? Icons.shopping_cart : Icons.menu,
            color: Palette.greenDark,
            size: 30,
          ),
          cartItems > 0 ? Container(
            padding: EdgeInsets.all(2.5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red
            ),
            child: Text(cartItems.toString(), style: TextStyle(color: Colors.white)),
          ) : Container()
        ]
      ),
      onPressed: () => scaffoldKey.currentState.openDrawer(),
    )
  );

  Widget _backButton(context, route) => Container(
        margin:
            EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.0375),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            customBorder: CircleBorder(),
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Palette.greenDark,
              size: 30,
            ),
          ),
        ),
      );

  Widget _logo(context) => Image.asset('assets/png/logo-colorful.png',
      width: MediaQuery.of(context).size.width / 1.75);

  Widget _title(context, route) => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.0375),
            child: Text(
              route == 'sell' ? 'Venda' : 'Serviços',
              style: TextStyle(color: Palette.greenDark),
            ),
          ),
        ],
      );

  Widget _notifications(context) => FlatButton(
        onPressed: () => this.scaffoldKey.currentState.openEndDrawer(),
        child: Container(
          child: Stack(
            alignment: unreadNotificationsCount > 0
                ? Alignment.topRight
                : Alignment.centerLeft,
            children: [
              Icon(Icons.notifications_none, size: 24, color: Colors.black),
              unreadNotificationsCount > 0
                  ? Container(
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      ),
                      child: Center(
                        child: Text(
                          unreadNotificationsCount.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.width * 0.022,
                          ),
                        ),
                      ),
                    )
                  : Container()
            ],
          ),
        ),
      );
}
