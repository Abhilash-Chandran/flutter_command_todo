import 'package:flutter_command_todo/commons/backend/base_store.dart';
import 'package:objectbox/objectbox.dart';
import 'package:uuid/uuid.dart';
import 'package:meta/meta.dart';

@Entity()
class User extends ObjectBoxStoreObject {
  final String id;
  String name;

  @Id()
  int oboxId;

  User({@required this.name}) : id = Uuid().v4();

  @override
  bool operator ==(o) =>
      o is User && o.id == id && o.name == name && o.oboxId == oboxId;

  @override
  int get hashCode => name.hashCode ^ id.hashCode ^ oboxId.hashCode;
}
