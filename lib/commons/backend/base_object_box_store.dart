import 'package:flutter_command_todo/commons/backend/base_store.dart';
import 'package:flutter_command_todo/objectbox.g.dart';
import 'package:flutter_command_todo/todo/models/todo.dart';

/// Todo: Imeplement all base operations for a ObjectBox database.
///  An Exmaple is given below.
///
/// Note: You will have to install ObjectBox for this to work appropriately.
/// https://github.com/objectbox/objectbox-dart

class ObjectBoxStore<T extends ObjectBoxStoreObject> implements StoreDao<T> {
  Box<T> objBox;
  Future<bool> init(Map<String, dynamic> options) async {
    assert(options != null);
    final _objBoxStore = options['obj_store'] as Store;
    objBox = await _objBoxStore.box<T>();
    if (objBox.isEmpty() && options.containsKey('initialValue')) {
      if (options['initialValue'] is T) {
        add(options['initialValue']);
      } else {
        print('Initial Value should of type $T');
      }
    }
    return objBox != null;
  }

  Future<T> add(T obj) async {
    final _id = objBox.put(obj);
    return objBox.get(_id);
  }

  Future<T> update(T obj) async {
    final _id = objBox.put(obj);
    return objBox.get(_id);
  }

  Future<bool> delete(T obj) async {
    return objBox.remove(obj.oboxId);
  }

  Future<bool> deleteAll() async {
    final totalCount = objBox.count();
    final _removedItems = objBox.removeAll();
    return _removedItems == totalCount;
  }

  Future<List<T>> fetchAll() async {
    return objBox.getAll();
  }

  @override
  Future<T> get(String id) async {
    throw UnimplementedError();
  }
}
