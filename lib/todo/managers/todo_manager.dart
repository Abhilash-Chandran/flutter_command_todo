import 'package:flutter_command/flutter_command.dart';
import 'package:flutter_command_todo/todo/models/todo.dart';
import 'package:flutter_command_todo/todo/services/todo_store.dart';
import 'package:get_it/get_it.dart';

class ToDoManager {
  ToDoStore _toDoStore = GetIt.I<ToDoStore>();

  Command<ToDo, ToDo> addTodoCommand;
  Command<ToDo, bool> deleteTodoCommand;
  Command<ToDo, ToDo> updateTodoCommand;
  Command<String, List<ToDo>> getAllToDoForUser;
  ToDoManager() {
    // Adds a todo to the backend
    addTodoCommand = Command.createAsync<ToDo, ToDo>(
        (todo) async => await _toDoStore.add(todo), null);
    // Deletes a todo from the backend
    deleteTodoCommand = Command.createAsync<ToDo, bool>(
        (todo) async => await _toDoStore.delete(todo), null);

    // Updates the todo
    // If the signature of the function being wrapped is same, following is also
    // valid.
    updateTodoCommand =
        Command.createAsync<ToDo, ToDo>(_toDoStore.update, null);

    // Retrieves all the Todos for the given userId.
    getAllToDoForUser = Command.createAsync<String, List<ToDo>>(
        _toDoStore.fetchAllTodosByUserId, []);
  }
}
