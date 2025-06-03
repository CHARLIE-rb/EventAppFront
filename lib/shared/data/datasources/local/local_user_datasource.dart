import 'package:flutterv1/shared/data/datasources/user_datasource.dart';
import 'package:flutterv1/shared/data/datasources/users_local_data_list.dart';
import 'package:flutterv1/shared/data/models/user_model.dart';

class LocalUserDatasource implements UserDataSource {
  final List<UserModel> _users = mockUserModel;

  @override
  Future<void> addUser(UserModel user) async {
    // Check if user already exists
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
      orElse: () => UserModel.vacio(),
    );
  }

  @override
  Future<void> updateUser(UserModel user) {
    final index = _users.indexWhere((u) => u.id == user.id);
    if (index != -1) {
      _users[index] = user;
    } else {
      throw Exception('User not found');
    }
    return Future.value();
  }
}
