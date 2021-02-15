import 'package:flutter_command_todo/commons/backend/base_hive_store.dart';
import 'package:flutter_command_todo/commons/backend/base_in_memory_store.dart';
import 'package:flutter_command_todo/commons/backend/base_store.dart';
import 'package:flutter_command_todo/todo/models/todo.dart';

/// This is an abstract representation of a ToDo Store, which can then be
/// implemented differently for different backends eg. InMemory, Hive, or
/// FireStore
abstract class ToDoStore implements StoreDao<ToDo> {
  Future<List<ToDo>> fetchAllTodosByUserId(String userId);
}

class IMToDoStore extends InMemoryStore<ToDo> implements ToDoStore {
  @override
  Future<List<ToDo>> fetchAllTodosByUserId(String userId) async {
    final allTodos =
        this.allObjects.where((element) => element.userId == userId);
    // return allTodos;
    return [...allTodos];
  }
}

class HiveToDoStore extends HiveStore<ToDo> implements ToDoStore {
  @override
  Future<List<ToDo>> fetchAllTodosByUserId(String userId) {

    return [...objBox.values]
  }
}
