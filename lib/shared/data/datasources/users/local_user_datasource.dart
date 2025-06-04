import 'package:flutterv1/shared/data/datasources/users/user_datasource.dart';
import 'package:flutterv1/shared/data/datasources/users/users_local_data_list.dart';
import 'package:flutterv1/shared/data/models/user_model.dart';

class LocalUserDatasource implements UserDataSource {
  final List<UserModel> _users = mockUserModel;

  @override
  Future<void> addUser(UserModel user) async {
    final existingUser = _users.firstWhere(
      (u) => u.id == user.id,
      orElse: () => UserModel.vacio(),
    );

    if (existingUser.id.isEmpty) {
      _users.add(user);
    }
  }

  @override
  Future<void> deleteUser(String userId) async {
    _users.removeWhere((user) => user.id == userId);
  }

  @override
  Future<List<UserModel>> getAllUsers() {
    return Future.value(_users);
  }

  @override
  Future<UserModel> getUserById(String userId) async {
    return _users.firstWhere(
      (user) => user.id == userId,
      orElse: () => throw Exception('User not found'),
    );
  }

  @override
  Future<void> updateUser(UserModel user) async {
    final index = _users.indexWhere((u) => u.id == user.id);
    if (index != -1) {
      _users[index] = user;
    } else {
      throw Exception('User not found');
    }
  }

  @override
  Future<UserModel> getUserByUsername(String username) async {
    return _users.firstWhere(
      (user) => user.name == username,
      orElse: () => throw Exception('User not found'),
    );
  }
}
