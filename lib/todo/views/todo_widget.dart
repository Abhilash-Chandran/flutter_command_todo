import 'package:flutter/material.dart';
import 'package:flutter_command_todo/commons/utils/utils.dart';
import 'package:flutter_command_todo/todo/managers/todo_manager.dart';
import 'package:flutter_command_todo/todo/models/todo.dart';
import 'package:flutter_command_todo/todo/views/add_todo_widget.dart';
import 'package:get_it/get_it.dart';

class ToDoItem extends StatefulWidget {
  final ToDo toDo;
  ToDoItem(this.toDo);
  @override
  _ToDoItemState createState() => _ToDoItemState();
}

class _ToDoItemState extends State<ToDoItem> {
  // bool selected = false;
  ToDoManager _toDoManager = GetIt.I<ToDoManager>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Card(
              elevation: 6,
              child: CheckboxListTile(
                value: widget.toDo.completed,
                dense: true,
                title: Text(
                  widget.toDo.description,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                subtitle: Text(
                  convertDateToString(widget.toDo.dueDate),
                  style: Theme.of(context).textTheme.caption,
                ),
                onChanged: (newValue) {
                  setState(() {
                    widget.toDo.completed = newValue ?? false;
                    _toDoManager.updateTodoCommand(widget.toDo);
                    // selected = newValue;
                  });
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Material(
              elevation: 4,
              type: MaterialType.circle,
              color: Colors.green[100],
              child: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => AddOrEditToDo(
                      toDo: widget.toDo,
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Material(
              elevation: 4,
              type: MaterialType.circle,
              color: Colors.red[100],
              child: IconButton(
                icon: Icon(Icons.delete_forever_rounded),
                onPressed: () {
                  _toDoManager.deleteTodoCommand(widget.toDo);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
