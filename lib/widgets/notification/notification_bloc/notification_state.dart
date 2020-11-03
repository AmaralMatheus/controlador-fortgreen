import 'package:controlador/models/notification.dart';

abstract class NotificationState {
  NotificationState([List props = const []]);
}

class UnloadedNotificationsState extends NotificationState {
  @override
  String toString() => 'Notificações não carregadas';
}

class LoadingNotificationsState extends NotificationState {
  @override
  String toString() => 'Carregando notificações';
}

class LoadedNotificationsState extends NotificationState {
  final List<NotificationModel> readNotifications;
  final List<NotificationModel> unreadNotifications;

  LoadedNotificationsState({this.readNotifications, this.unreadNotifications})
      : super([readNotifications, unreadNotifications]);

  @override
  String toString() => 'Notificações carregadas';
}

class NotificationFailure extends NotificationState {
  final String error;

  NotificationFailure({this.error}) : super([error]);

  @override
  String toString() => 'Falha ao buscar notificações';
}

class SettingNotificationAsRead extends NotificationState {
  @override
  String toString() => 'Marcando notificação como lida';
}

class NotificationSettedAsRead extends NotificationState {
  @override
  String toString() => 'Notificação marcada como lida, com sucesso';
}
