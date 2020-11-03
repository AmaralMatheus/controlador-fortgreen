import 'dart:async';
import 'package:meta/meta.dart';
import '../../../resources/controlador_api.dart';
import '../../../resources/storage.dart';
import '../../../resources/cache.dart';

class LoginRepository {
  final _api = ControladorApi();
  // final _storage = CacheProvider();
  // final _cache = Cache();

  Future<Map<String, dynamic>> authenticate(
      {@required String email, @required String password}) async {
    return await _api.doLogin(email, password);
  }
  
  Future<void> persistEmail(String email) async {
    // await _cache.set(key: 'username', value: {'username': email});
    return;
  }

  Future<void> persistId(int id) async {
    // await _storage.setClienteId(id: id.toString());
    return;
  }

  Future<Map<String, dynamic>> getUsername() async {
    // return await _cache.get(key: 'username');
  }

  Future<void> persistToken(String token) async {
    // await _cache.set(key: 'token', value: {'token': token});
    return;
  }

  Future<void> deleteClientData() async {
    // _api.cleanApiUserData();
    // await _storage.deleteInfos();
    return;
  }

  Future<Map<String, dynamic>> getToken() async {
    // return await _cache.get(key: 'token');
  }

  Future<void> forgotPassword({@required String email}) async {
    // await _api.forgotPassword(email: email);
  }

  Future<void> setFcmToken() async {
    // await _api.setFcmToken();
  }

  Future<bool> isCooperado({@required int userId}) async {
    // return await _api.checkCooperadoExists(userId);
  }

}
