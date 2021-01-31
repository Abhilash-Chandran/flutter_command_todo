import 'package:flutter_command_todo/commons/backend/base_in_memory_store.dart';
import 'package:flutter_command_todo/commons/backend/base_store.dart';
import 'package:flutter_command_todo/user/models/user.dart';

/// This is an abstract representation of a ToDo Store, which can then be
/// implemented differently for different backends eg. InMemory, Hive, or
/// FireStore
abstract class UserStore implements StoreDao<User> {}

class IMUserStore extends InMemoryStore<User> implements UserStore {}

// class HiveUserStore extends HiveStore<User> implements UserStore {}
