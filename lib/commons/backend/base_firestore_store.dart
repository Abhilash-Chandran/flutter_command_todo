import 'package:flutter_command_todo/commons/backend/base_store.dart';

/// Todo: Imeplement all base operations for a Firestore database.

class HiveStore<T extends StoreObject> implements StoreDao<T> {
  @override
  Future<T?> add(T obj) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future<bool> delete(T obj) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteAll() {
    // TODO: implement deleteAll
    throw UnimplementedError();
  }

  @override
  Future<List<T>> fetchAll() {
    // TODO: implement fetchAll
    throw UnimplementedError();
  }

  @override
  Future<T?> get(String id) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<bool> init(Map<String, dynamic> options) {
    // TODO: implement init
    throw UnimplementedError();
  }

  @override
  Future<T?> update(T obj) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
