import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_command_todo/commons/utils/utils.dart';
import 'package:flutter_command_todo/todo/managers/todo_manager.dart';
import 'package:flutter_command_todo/todo/models/todo.dart';
import 'package:flutter_command_todo/user/managers/user_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:uuid/uuid.dart';

class AddOrEditToDo extends StatefulWidget {
  final ToDo? toDo;
  AddOrEditToDo({this.toDo});
  @override
  _AddOrEditToDoState createState() => _AddOrEditToDoState();
}

class _AddOrEditToDoState extends State<AddOrEditToDo> {
  TextEditingController _controller = TextEditingController();

  ToDoManager _todoManager = GetIt.I<ToDoManager>();
  UserManager _userManager = GetIt.I<UserManager>();
  late ToDo tempTodo;
  DateTime? dueDate;
  @override
  void initState() {
    super.initState();
    tempTodo = widget.toDo ??
        ToDo(
          id: Uuid().v4(),
          description: '',
          dueDate: dueDate,
          userId: _userManager.getCurrentUser().id,
        );
    _controller.text = tempTodo.description;
    dueDate = tempTodo.dueDate;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Describe your Todo',
                border: OutlineInputBorder(),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Due Date : '),
                Text(convertDateToString(dueDate)),
                IconButton(
                    icon: Icon(Icons.calendar_today_rounded),
                    onPressed: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(DateTime.now().year + 5),
                      ).then((value) {
                        setState(() {
                          dueDate = value;
                        });
                      });
                    })
              ],
            ),
            Row(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red[300],
                    onPrimary: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'),
                ),
                Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green[300],
                    onPrimary: Colors.black,
                  ),
                  onPressed: () {
                    tempTodo.description = _controller.text;
                    tempTodo.dueDate = dueDate;
                    // Decides whether to update an existing todo or create a new todo
                    if (widget.toDo == null) {
                      _todoManager.addTodoCommand(tempTodo);
                    } else {
                      _todoManager.updateTodoCommand(widget.toDo);
                    }
                    Navigator.pop(context);
                  },
                  child: Text('Save Todo'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
