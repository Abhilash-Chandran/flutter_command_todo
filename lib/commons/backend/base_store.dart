import 'package:flutter_command_todo/objectbox.g.dart';

/// An abstract base class that reresents what are the possible operations or
/// methods that can performed in a store of specfic type.
///
/// Imagine an array that is allowed to hold only one specific type of object.
/// Imagine an RDBMS table to hold one Entity.
/// Image a bag of sugar cubes.
///
abstract class StoreDao<T> {
  /// Initialize the store object either in memory or in a database.
  Future<bool> init(Map<String, dynamic> options);

  Future<T> add(T obj);
  Future<T> get(String id);
  Future<T> update(T obj);
  Future<bool> delete(T obj);
  Future<bool> deleteAll();

  /// Fetch all the todo's for the current user.
  Future<List<T>> fetchAll();
}

/// This is abstract class that enforces every object that can be stored should
/// have [id] as attribute which is expected to be unique between objects of
/// same type.
///
/// The reason we setup a getter is because the imeplementer will have the
/// freedom choose whether this field should be final or not.
///
/// Having a final attribute in the abstract class will not allow the
/// implementation to override it.
///
abstract class StoreObject {
  String get id;
}

abstract class ObjectBoxStoreObject extends StoreObject {
  int get oboxId;
}
