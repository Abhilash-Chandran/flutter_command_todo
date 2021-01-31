// import 'package:flutter_command_todo/commons/services/base_store.dart';
// import 'package:flutter_command_todo/todo/models/todo.dart';

// /// Todo: Imeplement all base operations for a Hive database.
// ///  An Exmaple is given below.
// ///
// /// Note: You will have to install hive for this to work appropriately.

// class HiveStore<T extends StoreObject> implements StoreDao<T>{
//   Box<T> _hiveObjBox;
//   Future<bool> init(Map<String, dynamic> options) async {
//     assert(options != null);
//     _hiveObjBox = await Hive.openBox(options['storeName'] as String);
//     if (_hiveObjBox.isEmpty && options.containsKey('initialValue')) {
//       if (options['initialValue'] is T) {
//         add(options['initialValue']);
//       } else {
//         print('Initial Value should of type $T');
//       }
//     }
//     return _hiveObjBox.isOpen;
//   }

//   Future<T> add(T obj) async {
//     await _hiveObjBox.put(obj.id, obj);
//     return _hiveObjBox.get(obj.id);
//   }

//   Future<T> update(T obj) async {
//     _hiveObjBox.put(obj.id, obj);
//     return _hiveObjBox.get(obj.id);
//   }

//   Future<bool> delete(T obj) async {
//     await _hiveObjBox.delete(obj.id);
//     return _hiveObjBox.containsKey(obj.id);
//   }

//   Future<bool> deleteAll() async {
//     await _hiveObjBox.deleteAll(_hiveObjBox.keys);
//     return _hiveObjBox.isEmpty;
//   }

//   Future<List<T>> fetchAll() async {
//     return [..._hiveObjBox.values];
//   }

//  @override
//  Future<T> get(String id) async {
//    return _hiveObjBox.get(id);
//  }
// }
