import 'package:controlador/colors.dart';
import 'package:controlador/models/notification.dart';
import 'package:controlador/widgets/notification/notification_bloc/notification_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'notification_bloc/notification_event.dart';

class NotificationItem extends StatelessWidget {
  final List<NotificationModel> items;
  final bool opened;

  NotificationItem({this.items, this.opened = false});

  Widget _buildItem(BuildContext context, int index,
          NotificationBloc _notificationBloc) =>
      Column(
        children: [
          FlatButton(
            padding: EdgeInsets.zero,
            child: Container(
              width: MediaQuery.of(context).size.width - 20,
              decoration: BoxDecoration(
                  color: this.opened ? Colors.white : Colors.grey[100],
                  borderRadius: BorderRadius.circular(12.5)),
              margin: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: MediaQuery.of(context).size.width * 0.05),
              padding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: MediaQuery.of(context).size.width * 0.05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    items[index].titulo,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.justify,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    items[index].descricao,
                    style: TextStyle(fontWeight: FontWeight.w200),
                    textAlign: TextAlign.left,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
            onPressed: () {
              if (!items[index].lida) {
                _notificationBloc.dispatch(
                  SetNotificationRead(
                    notificationModel: this.items[index],
                  ),
                );
              }

              _notificationBloc.dispatch(GetNotificationsEvent());

              this._showDialog(context, items[index]);
            },
          ),
          if (items[index].lida) NotificationStripe()
        ],
      );

  @override
  Widget build(BuildContext context) {
    NotificationBloc _notificationBloc =
        BlocProvider.of<NotificationBloc>(context);

    return Column(
      children: items.isNotEmpty
          ? List<Widget>.generate(items.length, (int index) {
              return _buildItem(context, index, _notificationBloc);
            })
          : [
              Container(
                padding: EdgeInsets.only(top: 50),
                child: Text("Nenhuma notificação disponível"),
              )
            ],
    );
  }

  void _showDialog(BuildContext context, NotificationModel notification) =>
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(notification.titulo,
                textAlign: TextAlign.justify,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            content: Container(
                width: MediaQuery.of(context).size.width * 0.925,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      notification.descricao,
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    this._returnButton(context)
                  ],
                )),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
          );
        },
      );

  Widget _returnButton(BuildContext context) => Container(
        height: (MediaQuery.of(context).size.height * 0.075),
        width: MediaQuery.of(context).size.width * 0.77,
        decoration: BoxDecoration(
          color: Palette.greenLight,
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: FlatButton(
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          padding: EdgeInsets.zero,
          child: Text(
            'Voltar',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      );
}

class NotificationStripe extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
      margin: EdgeInsets.symmetric(
          vertical: 10, horizontal: MediaQuery.of(context).size.width * 0.1),
      decoration:
          BoxDecoration(border: Border.all(width: 1, color: Colors.grey[200])),
      height: 1);
}
