import 'package:flutterv1/features/auth/data/datasources/auth_data_source.dart';
import 'package:flutterv1/features/auth/data/mappers/user_mapper.dart';
import 'package:flutterv1/features/auth/domain/entities/user.dart';
import 'package:flutterv1/shared/data/datasources/users_local_data_list.dart';
import 'package:flutterv1/shared/data/models/user_model.dart';

class AuthLocalDataSourceImpl implements AuthDataSource {
  final UserMapper _userMapper;
  final List<UserModel> _mock = mockUserModel;

  AuthLocalDataSourceImpl(this._userMapper);

  @override
  Future<User> loginWithEmail(String email, String password) async {
    return _userMapper.toUser(
      _mock.firstWhere(
        (u) => u.email == email && u.password == password,
        orElse: () => throw Exception('Credenciales incorrectas'),
      ),
    );
  }

  @override
  Future<User> loginWithPin(String id, String pin) async {
    return _userMapper.toUser(
      _mock.firstWhere(
        (u) => u.id == id && u.pin == pin,
        orElse: () {
          throw Exception('Credenciales incorrectas');
        },
      ),
    );
  }

  @override
  Future<User> register(User user) async {
    _mock.add(_userMapper.toUserModel(user));
    return user;
  }
}
