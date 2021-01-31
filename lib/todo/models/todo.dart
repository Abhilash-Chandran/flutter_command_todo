import 'package:flutter_command_todo/commons/backend/base_store.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

/// Model class to hold the ToDo Object.
class ToDo extends StoreObject {
  /// Unique id of this todo to store in backend.
  final String id;

  /// Description of this todo.
  String description;

  /// A flag to denote if the to activity is complete
  bool completed;

  /// Due Date for this todo.
  DateTime dueDate;

  /// id of the user who created this todo.
  String userId;

  ToDo({
    @required this.description,
    this.dueDate,
    this.completed = false,
    @required this.userId,
  }) : id = Uuid().v4(); // Initializes id with a unique value.

  @override
  String toString() =>
      'Todo of user $userId with description $description and completed $completed';

  @override
  bool operator ==(o) =>
      o is ToDo &&
      o.description == description &&
      o.completed == completed &&
      o.dueDate == dueDate;

  @override
  int get hashCode =>
      description.hashCode ^
      userId.hashCode ^
      completed.hashCode ^
      dueDate.hashCode;
}
