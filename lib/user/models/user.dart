import 'package:flutter_command_todo/commons/backend/base_store.dart';
import 'package:uuid/uuid.dart';
import 'package:meta/meta.dart';

class User extends StoreObject {
  final String id;
  String name;

  User({@required this.name}) : id = Uuid().v4();

  @override
  bool operator ==(o) => o is User && o.id == id && o.name == name;

  @override
  int get hashCode => name.hashCode ^ id.hashCode;
}
