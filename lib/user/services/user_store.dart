import 'package:flutter_command_todo/commons/backend/base_hive_store.dart';
import 'package:flutter_command_todo/commons/backend/base_in_memory_store.dart';
import 'package:flutter_command_todo/commons/backend/base_store.dart';
import 'package:flutter_command_todo/user/models/user.dart';

/// This is an abstract representation of a ToDo Store, which can then be
/// implemented differently for different backends eg. InMemory, Hive, or
/// FireStore
///
/// This additional abstraction allows to abstract the backend implementation
/// away and add model specific functionalities. for eg. [userExists] is a
/// special use case which is not necessary for the ToDo model.
abstract class UserStore implements StoreDao<User> {
  late User currentUser;
  Future<User?> getUserByName(String name);
}

class IMUserStore extends InMemoryStore<User> implements UserStore {
  /// Verifies if the user already exists or not.
  /// Not the best implementation but for demo projects this is ok. :)
  @override
  Future<User?> getUserByName(String userName) async {
    return allObjects.firstWhere((element) => element.name == userName,
        orElse: () => User(id: '', name: ''));
  }

  @override
  late User currentUser;
}

/// A Store implementation using Hive as backend.

class HiveUserStore extends HiveStore<User> implements UserStore {
  @override
  late User currentUser;

  @override
  Future<User?> getUserByName(String name) async {
    final user = hiveObjBox.values.firstWhere(
      (element) => element.name == name,
      orElse: () => User(id: '', name: ''),
    );
    return user;
  }
}
