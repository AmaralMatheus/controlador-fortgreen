import 'package:controlador/models/notification.dart';
// import 'package:controlador/resources/controlador_api.dart';

class NotificationRepository {
  // final _api = controladorApi();

  Future<List<NotificationModel>> getUnreadNotifications() async {
    // return this._api.getNotifications(readNotifications: false);
  }

  Future<List<NotificationModel>> getReadNotifications() async {
    // return this._api.getNotifications(readNotifications: true);
  }

  Future setNotificationRead({NotificationModel notification}) async {
    // await this._api.setNotificationAsRead(notification: notification);
  }
}
