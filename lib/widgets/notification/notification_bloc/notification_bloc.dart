import 'notification_event.dart';
import 'notification_repository.dart';
import 'notification_state.dart';

import 'package:bloc/bloc.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationRepository _notificationRepository =
      NotificationRepository();

  @override
  NotificationState get initialState => UnloadedNotificationsState();

  @override
  Stream<NotificationState> mapEventToState(NotificationEvent event) async* {
    if (event is GetNotificationsEvent) yield* getNotifications(event);
    if (event is SetNotificationRead) yield* setNotification(event);
  }

  Stream<NotificationState> getNotifications(
      GetNotificationsEvent event) async* {
    yield LoadingNotificationsState();

    try {
      final notificationsList = await Future.wait([
        _notificationRepository.getUnreadNotifications(),
        _notificationRepository.getReadNotifications()
      ]);

      yield LoadedNotificationsState(
          unreadNotifications: notificationsList[0],
          readNotifications: notificationsList[1]);
    } catch (error) {
      yield NotificationFailure(error: error);
    }
  }

  Stream<NotificationState> setNotification(SetNotificationRead event) async* {
    yield SettingNotificationAsRead();

    try {
      await _notificationRepository.setNotificationRead(
          notification: event.notificationModel);

      yield NotificationSettedAsRead();
      //dispatch(GetNotificationsEvent());
    } catch (error) {
      yield NotificationFailure(error: error);
    }
  }
}
