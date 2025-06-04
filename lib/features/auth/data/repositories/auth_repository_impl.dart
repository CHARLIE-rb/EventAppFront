import 'package:flutterv1/features/auth/data/datasources/auth_data_source.dart';
import 'package:flutterv1/shared/domain/entities/user.dart';
import 'package:flutterv1/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource _authDataSource;

  AuthRepositoryImpl(this._authDataSource);

  @override
  Future<bool> loginWithEmail(String email, String password) async {
    final user = _authDataSource.loginWithEmail(email, password);
    return user;
  }

  @override
  Future<bool> loginWithPin(String username, String pin) async {
    return _authDataSource.loginWithPin(username, pin);
  }

  @override
  Future<bool> register(User user) {
    return _authDataSource.register(user);
  }
}
