// import 'dart:core';
// import 'dart:async';

// import 'package:mutex/mutex.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:meta/meta.dart';

// class CacheModel {
//   final String key;
//   final String value;

//   static const String tableName = "local_cache";
//   static const String columnKey = "item_key";
//   static const String columnValue = "item_value";

//   CacheModel.fromMap(Map<String, dynamic> map)
//       : key = map[CacheModel.columnKey],
//         value = map[CacheModel.columnValue];

//   Map<String, dynamic> toMap() => <String, dynamic>{
//         CacheModel.columnKey: this.key,
//         CacheModel.columnValue: this.value,
//       };

//   @override
//   String toString() => 'CacheModel { ${this.key}: ${this.value} }';
// }

// class CacheProvider {
//   static const String _path = 'cache.db';
//   static Mutex _mutex = Mutex();
//   final keyToken = 'token';
//   final keyClienteId = 'id';
//   final keyClienteEmail = 'email';
//   final keyPropertyId = 'propertyId';
//   final keyCurrentWeather = 'currentWeather';
//   final keyLocation = 'location';
//   final keyLastWeatherTime = 'lastWeatherTime';

//   static Future<Database> _open() async => await openDatabase(
//         _path,
//         version: 1,
//         onCreate: (Database db, int version) async {
//           await db.execute('''
//               create table ${CacheModel.tableName} (
//                   ${CacheModel.columnKey} text primary key,
//                   ${CacheModel.columnValue} text not null
//               )
//               ''');
//         },
//       );

//   static Future<void> write({String key, String value}) async {
//     try {
//       await CacheProvider._mutex.acquire();
//       final db = await CacheProvider._open();
//       await db.execute(
//         '''
//         insert or replace into ${CacheModel.tableName}
//           (${CacheModel.columnKey}, ${CacheModel.columnValue})
//           values(?, ?)
//         ''',
//         [key, value],
//       );
//       await db.close();
//     } catch (err) {
//       print(err);
//     } finally {
//       CacheProvider._mutex.release();
//     }
//   }

//   static Future<dynamic> read({String key}) async {
//     try {
//       await CacheProvider._mutex.acquire();
//       final db = await CacheProvider._open();

//       List<Map> items = await db.query(CacheModel.tableName,
//           columns: [CacheModel.columnKey, CacheModel.columnValue],
//           where: '${CacheModel.columnKey} = ?',
//           whereArgs: [key]);

//       final item = items.isNotEmpty ? CacheModel.fromMap(items.first) : null;

//       await db.close();
//       CacheProvider._mutex.release();
//       return item;
//     } catch (err) {
//       print(err);
//       CacheProvider._mutex.release();
//     }
//   }

//   static Future<void> delete({String key}) async {
//     try {
//       await CacheProvider._mutex.acquire();
//       final db = await CacheProvider._open();
//       await db.delete(
//         CacheModel.tableName,
//         where: '${CacheModel.columnKey} = ?',
//         whereArgs: [key],
//       );
//       await db.close();
//     } catch (err) {
//       print(err);
//     } finally {
//       CacheProvider._mutex.release();
//     }
//   }

//   static Future<void> clean() async {
//     try {
//       await CacheProvider._mutex.acquire();
//       final db = await CacheProvider._open();
//       await db.delete(CacheModel.tableName);
//       await db.close();
//     } catch (err) {
//       print(err);
//     } finally {
//       CacheProvider._mutex.release();
//     }
//   }

//   static Future<List<CacheModel>> readAll() async {
//     try {
//       await CacheProvider._mutex.acquire();
//       final db = await CacheProvider._open();
//       final items = (await db.query(
//         CacheModel.tableName,
//         columns: [
//           CacheModel.columnKey,
//           CacheModel.columnValue,
//         ],
//       ))
//           .map((v) => CacheModel.fromMap(v))
//           .toList();
//       await db.close();
//       return items;
//     } catch (err) {
//       print(err);
//     } finally {
//       CacheProvider._mutex.release();
//     }

//     return [];
//   }

//   Future<void> setToken({@required token}) async {
//     await write(key: 'token', value: token);
//   }

//   Future<CacheModel> getToken() async {
//     return await read(key: 'token');
//   }

//   Future<void> setFcmToken({@required fcmToken}) async {
//     await write(key: 'fcmtoken', value: fcmToken);
//   }

//   Future<CacheModel> getFcmToken() async {
//     return await read(key: 'fcmtoken');
//   }

//   Future<CacheModel> getClienteId() async {
//     return await read(key: keyClienteId);
//   }

//   Future<void> setClienteId({@required id}) async {
//     await write(key: keyClienteId, value: id);
//   }

//   Future<CacheModel> getPropertyId() async {
//     return await read(key: keyPropertyId);
//   }

//   Future<void> setPropertyId({@required propertyId}) async {
//     await write(key: keyPropertyId, value:  propertyId);
//   }

//   Future<CacheModel>  getCurrentWeather() async {
//     return await read(key: keyCurrentWeather);
//   }

//   Future<void> setCurrentWeather({@required currentWeather}) async {
//     await write(key: keyCurrentWeather, value: currentWeather);
//   }

//   Future<CacheModel> getLocation() async {
//     return await read(key: keyLocation);
//   }

//   Future<void> setLocation({@required location}) async {
//     await write(key: keyLocation, value: location);
//   }

//   Future<CacheModel> getLastWeatherTime() async {
//     return await read(key: keyLastWeatherTime);
//   }

//   Future<void> setLastWeatherTime({@required time}) async {
//     await write(key: keyLastWeatherTime, value: time);
//   }

//   Future<String> getEmail() async {
//     return await read(key: keyClienteEmail);
//   }

//   Future<void> setEmail({@required email}) async {
//     await write(key: keyClienteEmail, value: email);
//   }

//   Future<void> deleteInfos() async {
//     await delete(key: 'token');
//     await delete(key: keyClienteId);
//     await delete(key: keyCurrentWeather);
//     await delete(key: keyLocation);
//     await delete(key: keyPropertyId);
//     await delete(key: keyLastWeatherTime);
//     return;
//   }

//   Future<void> deleteInfosWeather() async {
//     await delete(key: keyCurrentWeather);
//     await delete(key: keyLocation);
//     return;
//   }
// }
