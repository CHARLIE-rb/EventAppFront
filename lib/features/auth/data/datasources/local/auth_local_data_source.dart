import 'package:flutterv1/features/auth/data/datasources/auth_data_source.dart';
import 'package:flutterv1/features/auth/data/mappers/user_mapper.dart';
import 'package:flutterv1/shared/domain/entities/user.dart';
import 'package:flutterv1/shared/data/datasources/users/users_local_data_list.dart';
import 'package:flutterv1/shared/data/models/user_model.dart';

class AuthLocalDataSourceImpl implements AuthDataSource {
  final UserMapper _userMapper;
  final List<UserModel> _mock = mockUserModel;

  AuthLocalDataSourceImpl(this._userMapper);

  @override
  Future<bool> loginWithEmail(String email, String password) async {
    _mock.firstWhere(
      (u) => u.email == email && u.password == password,
      orElse: () => throw Exception('Credenciales incorrectas'),
    );
    return true;
  }

  @override
  Future<bool> loginWithPin(String username, String pin) async {
    _mock.firstWhere(
      (u) => u.name == username && u.pin == pin,
      orElse: () {
        throw Exception('Credenciales incorrectas');
      },
    );
    return true;
  }

  @override
  Future<bool> register(User user) async {
    _mock.add(_userMapper.toUserModel(user));
    return true;
  }
}
