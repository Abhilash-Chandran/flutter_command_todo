import 'package:flutter_command_todo/todo/managers/todo_manager.dart';
import 'package:flutter_command_todo/todo/services/todo_store.dart';
import 'package:flutter_command_todo/user/managers/user_manager.dart';
import 'package:flutter_command_todo/user/services/user_store.dart';
import 'package:get_it/get_it.dart';

/// Get it service locator instance
final getIt = GetIt.instance;

/// Intialize and instantiate various services like the backend and the managers.
Future<void> initialSetUp(StoreType storeType) async {
  // First set up and register the backend services.

  // Set up the User object store.
  getIt.registerSingletonAsync<UserStore>(() async {
    UserStore userStore;
    switch (storeType) {
      case StoreType.Hive:

        /// Initialize hive store for user model
        // userStore = HiveUserStore();
        // await userStore.init({'storeName': 'Users'});
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
        // todoStore = HiveToDoStore();
        // await todoStore.init({'storeName': 'Todos'});
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
      dependsOn: [UserStore]);
  getIt.registerSingletonAsync(() async => ToDoManager(),
      dependsOn: [ToDoStore]);
}

enum StoreType {
  InMemory,
  Hive,
  Firebase,
}
