import 'package:flutter_command_todo/commons/backend/base_store.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import 'package:meta/meta.dart';

part 'user.g.dart';

@HiveType(typeId: 2)
class User extends StoreObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  String name;

  User({@required this.name}) : id = Uuid().v4();

  @override
  bool operator ==(o) => o is User && o.id == id && o.name == name;

  @override
  int get hashCode => name.hashCode ^ id.hashCode;
}
