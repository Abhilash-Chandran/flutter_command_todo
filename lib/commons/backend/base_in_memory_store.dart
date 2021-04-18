import 'package:flutter_command_todo/commons/backend/base_store.dart';

class InMemoryStore<T extends StoreObject> implements StoreDao<T> {
  List<T> allObjects = [];

  Future<T> add(T obj) async {
    allObjects.add(obj);
    return allObjects.firstWhere((element) => element.id == obj.id);
  }

  Future<bool> delete(T obj) async {
    allObjects.removeWhere((element) => element.id == obj.id);
    return !allObjects.contains(obj);
  }

  Future<T> update(T obj) async {
    var objIndex = allObjects.indexWhere((element) => element.id == obj.id);
    allObjects[objIndex] = obj;
    return allObjects[objIndex];
  }

  Future<List<T>> fetchAll() async {
    return [...allObjects];
  }

  Future<bool> init(Map<String, dynamic> options) async {
    allObjects = [];
    return allObjects.isEmpty;
  }

  Future<bool> deleteAll() async {
    allObjects = [];
    return allObjects.isEmpty;
  }

  @override
  Future<T> get(String id) async {
    return allObjects.firstWhere((element) => element.id == id);
  }
}
