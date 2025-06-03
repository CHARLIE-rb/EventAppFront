import 'package:flutterv1/features/auth/data/datasources/auth_data_source.dart';
import 'package:flutterv1/shared/data/datasources/credential_storage.dart';
import 'package:flutterv1/features/auth/domain/entities/user.dart';
import 'package:flutterv1/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource _authDataSource;
  // final CredentialStorage _credentialStorage;
  // User? _current;

  AuthRepositoryImpl(this._authDataSource);

  @override
  Future<User> loginWithEmail(String email, String password) async {
    final user = _authDataSource.loginWithEmail(email, password);
    // _current = user;
    // _credentialStorage.saveCredentials(email, password);
    return user;
  }

  @override
  Future<User> loginWithPin(String id, String pin) async {
    return _authDataSource.loginWithPin(id, pin);
  }

  // @override
  // User? get currentUser => _current;

  // @override
  // Future<void> logout() async {
  //   await _credentialStorage.clearCredentials();
  //   _current = null;
  // }

  @override
  Future<User> register(User user) {
    return _authDataSource.register(user);
  }

  // Future<void> loadCredentials() async {
  //   final cred = await _credentialStorage.loadCredentials();
  //   if (cred != null) {
  //     try {
  //       _current = await loginWithEmail(cred['user']!, cred['pass']!);
  //     } catch (_) {
  //       // Ignore errors, user might not exist
  //     }
  //   }
  // }
}
