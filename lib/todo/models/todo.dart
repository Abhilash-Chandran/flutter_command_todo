import 'package:flutter_command_todo/commons/backend/base_store.dart';
import 'package:hive/hive.dart';

part 'todo.g.dart';

/// Model class to hold the ToDo Object.
@HiveType(typeId: 1)
class ToDo extends StoreObject {
  /// Unique id of this todo to store in backend.
  @HiveField(0)
  final String id;

  /// Description of this todo.
  @HiveField(1)
  String description;

  /// A flag to denote if the to activity is complete
  @HiveField(2)
  bool completed;

  /// Due Date for this todo.
  @HiveField(3)
  DateTime? dueDate;

  /// id of the user who created this todo.
  @HiveField(4)
  String userId;

  ToDo({
    required this.id,
    required this.description,
    required this.userId,
    this.dueDate,
    this.completed = false,
  }); // Initializes id with a unique value.

  @override
  String toString() =>
      'Todo of user $userId with description $description and completed $completed';

  @override
  bool operator ==(o) =>
      o is ToDo &&
      o.description == description &&
      o.completed == completed &&
      o.dueDate == dueDate &&
      o.id == id;

  @override
  int get hashCode =>
      id.hashCode ^
      description.hashCode ^
      userId.hashCode ^
      completed.hashCode ^
      dueDate.hashCode;
}
