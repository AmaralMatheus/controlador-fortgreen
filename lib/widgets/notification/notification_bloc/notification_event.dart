import 'package:controlador/models/notification.dart';

abstract class NotificationEvent {
  NotificationEvent([List props = const []]);
}

class GetNotificationsEvent extends NotificationEvent {
  @override
  String toString() => 'Buscando notificações';
}

class SetNotificationRead extends NotificationEvent {
  final NotificationModel notificationModel;

  SetNotificationRead({this.notificationModel}) : super([notificationModel]);

  @override
  String toString() => 'Marcando notificação como lida';
}
