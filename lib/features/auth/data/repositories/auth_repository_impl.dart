import 'package:events_app/features/auth/data/datasources/auth_data_source.dart';
import 'package:events_app/shared/data/mappers/user_mapper.dart';
import 'package:events_app/shared/domain/entities/user.dart';
import 'package:events_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource _authDataSource;
  final UserMapper _userMapper;

  AuthRepositoryImpl(this._authDataSource, this._userMapper);

  @override
  Future<bool> loginWithEmail(String email, String password) async {
    return _authDataSource.loginWithEmail(email, password);
  }

  @override
  Future<bool> loginWithPin(String username, String pin) async {
    return _authDataSource.loginWithPin(username, pin);
  }

  @override
  Future<bool> register(User user) {
    return _authDataSource.register(_userMapper.toModel(user));
  }
}
