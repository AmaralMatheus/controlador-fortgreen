// import 'dart:async';
// import "dart:convert";

// import 'package:meta/meta.dart';

// import './storage.dart';

// class Cache {
//   Future<Map<String, dynamic>> get({@required String key}) async {
//     final cached = await CacheProvider.read(key: key);

//     if (cached != null) {
//       return json.decode(cached.value);
//     } else {
//       return null;
//     }
//   }

//   Future<List<Map<String, dynamic>>> getList({@required String key}) async {
//     final cached = await CacheProvider.read(key: key);

//     if (cached != null) {
//       List<Map<String, dynamic>> decoded = (json.decode(cached.value) as List)
//           .map((e) => Map<String, dynamic>.from(e))
//           .toList();
//       return decoded;
//     }

//     return [];
//   }

//   Future<void> set({
//     @required String key,
//     @required Map<String, dynamic> value,
//   }) async =>
//       await CacheProvider.write(
//           key: key, value: JsonEncoder.withIndent("").convert(value));

//   Future<void> setList({
//     @required String key,
//     @required List<Map<String, dynamic>> list,
//   }) async =>
//       await CacheProvider.write(key: key, value: json.encode(list));

//   Future<void> clean() async => await CacheProvider.clean();

//   Future<void> delete({
//     @required String key,
//   }) async =>
//       await CacheProvider.delete(key: key);
// }
