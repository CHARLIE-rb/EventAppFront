import 'package:events_app/shared/domain/entities/user.dart';
import 'package:events_app/shared/domain/usecases/users/create_user.dart';
import 'package:events_app/shared/domain/usecases/users/delete_user.dart';
import 'package:events_app/shared/domain/usecases/users/get_all_users.dart';
import 'package:events_app/shared/domain/usecases/users/get_user_by_email.dart';
import 'package:events_app/shared/domain/usecases/users/get_user_by_id.dart';
import 'package:events_app/shared/domain/usecases/users/get_users_by_ids.dart';
import 'package:events_app/shared/domain/usecases/users/update_user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  final CreateUser _createUser;
  final GetUserByEmail _getUserByEmail;
  final GetAllUsers _getAllUsers;
  final DeleteUser _deleteUser;
  final GetUserById _getUserById;
  final UpdateUser _updateUser;
  final GetUsersByIds _getUsersByIds;
  UserProvider(
    this._createUser,
    this._getUserByEmail,
    this._getAllUsers,
    this._deleteUser,
    this._getUserById,
    this._updateUser,
    this._getUsersByIds,
  );

  Future<List<User>?> getUsersByIds(List<String> userIds) async {
    if (userIds.isEmpty) {
      return [];
    }
    return await _getUsersByIds(userIds);
  }

  Future<void> createUser(User user) async {
    await _createUser(user);
    notifyListeners();
  }

  Future<User?> getUserByEmail(String email) async {
    return await _getUserByEmail(email);
  }

  Future<List<User>> getAllUsers() async {
    return await _getAllUsers();
  }

  Future<void> deleteUser(String userId) async {
    await _deleteUser(userId);
    notifyListeners();
  }

  Future<User?> getUserById(String userId) async {
    return await _getUserById(userId);
  }

  Future<void> updateUser(User user) async {
    await _updateUser(user);
    notifyListeners();
  }
}
