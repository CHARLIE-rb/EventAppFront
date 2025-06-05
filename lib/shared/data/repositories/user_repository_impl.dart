import 'package:flutterv1/shared/data/mappers/user_mapper.dart';
import 'package:flutterv1/shared/domain/entities/user.dart';
import 'package:flutterv1/shared/data/datasources/users/user_datasource.dart';
import 'package:flutterv1/shared/domain/repositories/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final UserDataSource _userDataSource;
  final UserMapper userMapper;
  UserRepositoryImpl(this._userDataSource, this.userMapper);
  @override
  Future<void> addUser(User user) async {
    final userDataModel = userMapper.toModel(user);
    return _userDataSource.addUser(userDataModel);
  }

  @override
  Future<void> deleteUser(String userId) async {
    return _userDataSource.deleteUser(userId);
  }

  @override
  Future<List<User>> getAllUsers() async {
    try {
      final userModels = await _userDataSource.getAllUsers();
      return userModels.map((model) => userMapper.toUser(model)).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<User?> getUserById(String userId) async {
    try {
      final userModel = await _userDataSource.getUserById(userId);
      return userMapper.toUser(userModel);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> updateUser(User user) async {
    final userDataModel = userMapper.toModel(user);
    return _userDataSource.updateUser(userDataModel);
  }

  @override
  Future<User?> getUserByUsername(String username) async {
    try {
      final userModel = await _userDataSource.getUserByUsername(username);
      return userMapper.toUser(userModel);
    } catch (_) {
      return null;
    }
  }
}
