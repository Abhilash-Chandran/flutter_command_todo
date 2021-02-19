import 'package:flutter/material.dart';
import 'package:flutter_command_todo/service_locator.dart';
import 'package:flutter_command_todo/todo/views/todos_widget.dart';
import 'package:flutter_command_todo/user/views/user_login.dart';
import 'package:get_it/get_it.dart';

void main() {
  // use StoreType.Hive for Hive based backend.
  initialSetUp(StoreType.Hive);
  runApp(Loader());
}

class Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
        future: GetIt.instance.allReady(
          timeout: Duration(seconds: 5),
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            return TodoApp();
          }
          if (snapshot.hasError) {
            return Center(
              child: Card(
                child: Center(
                  child: Text('''Some Thing went wrong while loading the app.
                 Please try again later'''),
                ),
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      color: Colors.blueGrey,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => UserLogin(), // Screen to get the user name
        '/todos': (context) =>
            ToDos(), // Screen to show the todo's of the user.
      },
      initialRoute: '/',
    );
  }
}
