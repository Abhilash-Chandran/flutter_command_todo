import 'package:flutter/material.dart';
import 'package:flutter_command_todo/service_locator.dart';
import 'package:flutter_command_todo/todo/views/todos_widget.dart';
import 'package:flutter_command_todo/user/views/user_login.dart';
import 'package:get_it/get_it.dart';

void main() async {
  // use StoreType.Hive for Hive based backend.
  await initialSetUp(StoreType.InMemory);
  await GetIt.instance.allReady();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
