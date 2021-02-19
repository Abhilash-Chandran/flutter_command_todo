import 'package:flutter_command_todo/todo/managers/todo_manager.dart';
import 'package:flutter_command_todo/todo/models/todo.dart';
import 'package:flutter_command_todo/todo/services/todo_store.dart';
import 'package:flutter_command_todo/user/managers/user_manager.dart';
import 'package:flutter_command_todo/user/models/user.dart';
import 'package:flutter_command_todo/user/services/user_store.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Get it service locator instance
final getIt = GetIt.instance;

/// Intialize and instantiate various services like the backend and the managers.
Future<void> initialSetUp(StoreType storeType) async {
  // Pre setup e.g. initialize Hive
  if (storeType == StoreType.Hive) {
    // Intialize Hive and register adapters.
    await Hive.initFlutter();
    _registerHiveAdapters();
  }
  // Now set up and register the backend services.
  // Set up the User object store.
  getIt.registerSingletonAsync<UserStore>(() async {
    UserStore userStore;
    switch (storeType) {
      case StoreType.Hive:
        // Initialize hive store for user model
        userStore = HiveUserStore();
        await userStore.init({'storeName': 'Users'});
        break;
      default:
        userStore = IMUserStore();
        await userStore.init({});
    }
    return userStore;
  });

  // Set up the Todo object store.
  getIt.registerSingletonAsync<ToDoStore>(() async {
    ToDoStore todoStore;
    switch (storeType) {
      case StoreType.Hive:

        /// Initialize hive store for user model
        todoStore = HiveToDoStore();
        await todoStore.init({'storeName': 'Todos'});
        break;
      // case StoreType.Firebase
      // Handle initialization of Firestore.
      default:
        todoStore = IMToDoStore();
        await todoStore.init({});
    }
    return todoStore;
  });

  // Second set up all the managers which the UI elements would contact.
  getIt.registerSingletonAsync(() async => UserManager(),
      dependsOn: [UserStore, ToDoStore]);
  getIt.registerSingletonAsync(() async => ToDoManager(),
      dependsOn: [UserManager]);
}

void _registerHiveAdapters() {
  Hive.registerAdapter(ToDoAdapter());
  Hive.registerAdapter(UserAdapter());
}

enum StoreType {
  InMemory,
  Hive,
  Firebase,
}
