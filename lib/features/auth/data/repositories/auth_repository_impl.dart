import 'package:flutterv1/features/auth/data/datasources/auth_data_source.dart';
import 'package:flutterv1/features/auth/data/mappers/user_mapper.dart';
import 'package:flutterv1/features/auth/domain/entities/user.dart';
import 'package:flutterv1/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource _authDataSource;
  final UserMapper _userMapper;
  User? _current;

  AuthRepositoryImpl(this._authDataSource, this._userMapper);

  @override
  Future<User> loginWithEmail(String email, String password) async {
    final model = await _authDataSource.loginWithEmail(email, password);
    _current = _userMapper.toUser(model);
    return _current!;
  }

  @override
  Future<User> loginWithPin(String id, String pin) async {
    final model = await _authDataSource.loginWithPin(id, pin);
    _current = _userMapper.toUser(model);
    return _current!;
  }

  @override
  User? get currentUser => _current;

  @override
  Future<void> logout() async {
    _current = null;
  }

  @override
  Future<User> register(User user) {
    final model = _authDataSource.register(_userMapper.toModel(user));
    return model.then((value) {
      _current = _userMapper.toUser(value);
      return _current!;
    });
  }
}
