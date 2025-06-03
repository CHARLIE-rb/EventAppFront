import 'package:flutterv1/features/auth/data/mappers/user_mapper.dart';
import 'package:flutterv1/features/auth/domain/entities/user.dart';
import 'package:flutterv1/shared/data/datasources/user_datasource.dart';
import 'package:flutterv1/shared/domain/repositories/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final UserDataSource _userDataSource;
  final UserMapper userMapper;
  UserRepositoryImpl(this._userDataSource, this.userMapper);
  @override
  Future<void> addUser(User user) {
    final userDataModel = userMapper.toUserModel(user);
    return _userDataSource.addUser(userDataModel);
  }

  @override
  Future<void> deleteUser(String userId) {
    return _userDataSource.deleteUser(userId);
  }

  @override
  Future<List<User>> getAllUsers() {
    return _userDataSource.getAllUsers().then((userModels) {
      return userModels.map((model) => userMapper.toUser(model)).toList();
    });
  }

  @override
  Future<User> getUserById(String userId) {
    return _userDataSource.getUserById(userId).then((userModel) {
      return userMapper.toUser(userModel);
    });
  }

  @override
  Future<void> updateUser(User user) {
    final userDataModel = userMapper.toUserModel(user);
    return _userDataSource.updateUser(userDataModel);
  }
}
