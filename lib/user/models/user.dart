import 'package:flutter_command_todo/commons/backend/base_store.dart';
import 'package:meta/meta.dart';

class User extends StoreObject {
  final String id;
  String name;

  User({
    @required this.id,
    @required this.name,
  });

  @override
  bool operator ==(o) => o is User && o.id == id && o.name == name;

  @override
  int get hashCode => name.hashCode ^ id.hashCode;
}
