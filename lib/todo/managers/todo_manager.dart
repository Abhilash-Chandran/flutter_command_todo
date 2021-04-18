import 'package:flutter_command/flutter_command.dart';
import 'package:flutter_command_todo/todo/models/todo.dart';
import 'package:flutter_command_todo/todo/services/todo_store.dart';
import 'package:flutter_command_todo/user/managers/user_manager.dart';
import 'package:get_it/get_it.dart';

class ToDoManager {
  ToDoStore _toDoStore = GetIt.I<ToDoStore>();
  late UserManager _userManager;
  late Command<ToDo, ToDo?> addTodoCommand;
  late Command<ToDo, bool> deleteTodoCommand;
  late Command<ToDo, ToDo?> updateTodoCommand;
  late Command<String, List<ToDo>> getAllToDoForUser;
  ToDo emptyTodo = ToDo(
    description: '',
    id: '',
    userId: '',
  );
  ToDoManager() {
    // Adds a todo to the backend
    addTodoCommand = Command.createAsync<ToDo, ToDo?>(addTodo, emptyTodo);
    // Deletes a todo from the backend
    deleteTodoCommand = Command.createAsync<ToDo, bool>((todo) async {
      return await _toDoStore.delete(todo!);
    }, false);
    _userManager = GetIt.I<UserManager>();
    // Updates the todo
    // If the signature of the function being wrapped is same, following is also
    // valid.
    updateTodoCommand = Command.createAsync<ToDo, ToDo?>(updateTodo, null);

    // Retrieves all the Todos for the given userId.
    getAllToDoForUser = Command.createAsync<String, List<ToDo>>(
        (userName) async => _toDoStore.fetchAllTodosByUserId(userName!), []);

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

  Future<ToDo?> addTodo(ToDo? todo) async {
    return await _toDoStore.add(todo!);
  }

  Future<ToDo?> updateTodo(ToDo? todo) async {
    return await _toDoStore.update(todo!);
  }
}
