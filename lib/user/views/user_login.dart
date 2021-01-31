import 'package:flutter/material.dart';
import 'package:flutter_command_todo/todo/managers/todo_manager.dart';
import 'package:flutter_command_todo/user/managers/user_manager.dart';
import 'package:flutter_command_todo/user/models/user.dart';
import 'package:get_it/get_it.dart';

class UserLogin extends StatefulWidget {
  @override
  _UserLoginState createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  UserManager _userManager = GetIt.I<UserManager>();
  ToDoManager _toDoManager = GetIt.I<ToDoManager>();

  TextEditingController _userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.amberAccent,
          child: Center(
            child: FractionallySizedBox(
              heightFactor: 0.6,
              widthFactor: 0.8,
              child: Card(
                color: Colors.white70,
                child: Column(
                  children: [
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: TextFormField(
                        controller: _userNameController,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            labelStyle: TextStyle(color: Colors.black),
                            labelText: 'User Name',
                            contentPadding: EdgeInsets.all(8.0)),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.accents.first,
                          onPrimary: Colors.black,
                        ),
                        child: Text('Show My Todos'),
                        onPressed: () async {
                          // create the user if the user doesn't exist already.
                          final _existingUser = await _userManager
                              .getUserByName(_userNameController.text);
                          if (_existingUser == null) {
                            _userManager.createUserCommand(
                                User(name: _userNameController.text));
                          } else {
                            _userManager.setCurrentUser(_existingUser);
                            _toDoManager.getAllToDoForUser(
                                _userManager.getCurrentUser().id);
                          }
                          Navigator.pushNamed(context, '/todos');
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}