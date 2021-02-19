import 'package:flutter_command_todo/commons/backend/base_store.dart';
import 'package:hive/hive.dart';

/// Note: You will have to install hive for this to work appropriately.

class HiveStore<T extends StoreObject> implements StoreDao<T> {
  Box<T> hiveObjBox;
  Future<bool> init(Map<String, dynamic> options) async {
    assert(options != null);
    hiveObjBox = await Hive.openBox(options['storeName'] as String);
    if (hiveObjBox.isEmpty && options.containsKey('initialValue')) {
      if (options['initialValue'] is T) {
        add(options['initialValue']);
      } else {
        print('Initial Value should be of type $T');
      }
    }
    return hiveObjBox.isOpen;
  }

  Future<T> add(T obj) async {
    await hiveObjBox.put(obj.id, obj);
    return hiveObjBox.get(obj.id);
  }

  Future<T> update(T obj) async {
    hiveObjBox.put(obj.id, obj);
    return hiveObjBox.get(obj.id);
  }

  Future<bool> delete(T obj) async {
    await hiveObjBox.delete(obj.id);
    return hiveObjBox.containsKey(obj.id);
  }

  Future<bool> deleteAll() async {
    await hiveObjBox.deleteAll(hiveObjBox.keys);
    return hiveObjBox.isEmpty;
  }

  Future<List<T>> fetchAll() async {
    return [...hiveObjBox.values];
  }

  @override
  Future<T> get(String id) async {
    return hiveObjBox.get(id);
  }
}
