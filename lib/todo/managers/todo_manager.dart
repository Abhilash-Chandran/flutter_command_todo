import 'package:flutter_command/flutter_command.dart';
import 'package:flutter_command_todo/todo/models/todo.dart';
import 'package:flutter_command_todo/todo/services/todo_store.dart';
import 'package:flutter_command_todo/user/managers/user_manager.dart';
import 'package:get_it/get_it.dart';

class ToDoManager {
  ToDoStore _toDoStore = GetIt.I<ToDoStore>();
  UserManager _userManager;
  Command<ToDo, ToDo> addTodoCommand;
  Command<ToDo, bool> deleteTodoCommand;
  Command<ToDo, ToDo> updateTodoCommand;
  Command<String, List<ToDo>> getAllToDoForUser;
  ToDoManager() {
    // Adds a todo to the backend
    addTodoCommand = Command.createAsync<ToDo, ToDo>(
        (todo) async => _toDoStore.add(todo), null);
    // Deletes a todo from the backend
    deleteTodoCommand = Command.createAsync<ToDo, bool>(
        (todo) async => _toDoStore.delete(todo), null);
    _userManager = GetIt.I<UserManager>();
    // Updates the todo
    // If the signature of the function being wrapped is same, following is also
    // valid.
    updateTodoCommand =
        Command.createAsync<ToDo, ToDo>(_toDoStore.update, null);

    // Retrieves all the Todos for the given userId.
    getAllToDoForUser = Command.createAsync<String, List<ToDo>>(
        _toDoStore.fetchAllTodosByUserId, []);

    // Following listeners reloads the todo Lists in UI.
    addTodoCommand.listen((__, _) {
      getAllToDoForUser(_userManager.getCurrentUser().id);
    });
    updateTodoCommand.listen((__, _) {
      getAllToDoForUser(_userManager.getCurrentUser().id);
    });
    deleteTodoCommand.listen((__, _) {
      getAllToDoForUser(_userManager.getCurrentUser().id);
    });
  }
}
