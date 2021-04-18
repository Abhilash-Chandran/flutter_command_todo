import 'package:flutter/material.dart';
import 'package:flutter_command/command_builder.dart';
import 'package:flutter_command_todo/todo/managers/todo_manager.dart';
import 'package:flutter_command_todo/todo/models/todo.dart';
import 'package:flutter_command_todo/todo/views/add_todo_widget.dart';
import 'package:flutter_command_todo/todo/views/todo_widget.dart';
import 'package:flutter_command_todo/user/managers/user_manager.dart';
import 'package:flutter_command_todo/user/models/user.dart';
import 'package:get_it/get_it.dart';

class ToDos extends StatefulWidget {
  @override
  _ToDosState createState() => _ToDosState();
}

class _ToDosState extends State<ToDos> {
  ToDoManager _toDoManager = GetIt.I<ToDoManager>();
  UserManager _userManager = GetIt.I<UserManager>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.accents.first,
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) => AddOrEditToDo());
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: Center(
          child: Card(
            color: Colors.amberAccent,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CommandBuilder<User, User>(
                  command: _userManager.setCurrentUserCommand,
                  onData: (_, _currentUser, __) => Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Hi ${_currentUser.name}',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      Expanded(
                        child: FractionallySizedBox(
                          heightFactor: 0.85,
                          widthFactor: 0.95,
                          child: CommandBuilder<void, List<ToDo>>(
                              command: _toDoManager.getAllToDoForUser,
                              onData: (context, todos, _) {
                                return FractionallySizedBox(
                                  widthFactor: 0.9,
                                  // heightFactor: 0.85,
                                  child: Card(
                                    color: Colors.white70,
                                    child: ListView(
                                      shrinkWrap: true,
                                      children: todos
                                          .map((e) => ToDoItem(e))
                                          .toList(),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FloatingActionButton(
                      heroTag: 'logout',
                      backgroundColor: Colors.black45,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.account_circle,
                        color: Colors.amberAccent,
                      ),
                      mini: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
