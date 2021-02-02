import 'package:flutter_command/flutter_command.dart';
import 'package:flutter_command_todo/user/models/user.dart';
import 'package:flutter_command_todo/user/services/user_store.dart';
import 'package:get_it/get_it.dart';

class UserManager {
  /// Retrieve the user Store.
  UserStore _userStore = GetIt.I<UserStore>();

  Command<User, User> createUserCommand;

  // Command<String, bool> userExistsCommand;
  UserManager() {
    createUserCommand = Command.createAsync<User, User>(
      createUser,
      null, // this null should be handled in the ui. Or a dummy user object can
      // be returned and handled accordingly.
    );
  }

  /// The core function that handle the creation of user.
  Future<User> createUser(User user) async {
    // Save the user to the store.
    User _newUser = await _userStore.add(user);
    setCurrentUser(_newUser);
    return _newUser;
  }

  /// Verifies if the user name already exists in the bakend and returns it.
  Future<User> getUserByName(String userName) {
    return _userStore.getUserByName(userName);
  }

  setCurrentUser(User user) {
    _userStore.currentUser = user;
  }

  User getCurrentUser() {
    return _userStore.currentUser;
  }
}
