import 'package:flutterv1/features/auth/data/datasources/auth_data_source.dart';
import 'package:flutterv1/features/auth/data/datasources/credential_storage.dart';
import 'package:flutterv1/features/auth/data/mappers/user_mapper.dart';
import 'package:flutterv1/features/auth/domain/entities/user.dart';
import 'package:flutterv1/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource _authDataSource;
  final UserMapper _userMapper;
  final CredentialStorage _credentialStorage;
  User? _current;

  AuthRepositoryImpl(
    this._authDataSource,
    this._userMapper,
    this._credentialStorage,
  );

  @override
  Future<User> loginWithEmail(String email, String password) async {
    final user = _userMapper.toUser(
      await _authDataSource.loginWithEmail(email, password),
    );
    _current = user;
    _credentialStorage.saveCredentials(email, password);
    return user;
  }

  @override
  Future<User> loginWithPin(String id, String pin) async {
    final model = await _authDataSource.loginWithPin(id, pin);
    return _userMapper.toUser(model);
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
    return model.then((value) => _userMapper.toUser(value));
  }

  Future<void> loadCredentials() async {
    final cred = await _credentialStorage.loadCredentials();
    if (cred != null) {
      try {
        _current = await loginWithEmail(cred['user']!, cred['pass']!);
      } catch (_) {
        // Ignore errors, user might not exist
      }
    }
  }
}
