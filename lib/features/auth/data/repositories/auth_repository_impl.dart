// lib/features/auth/data/repositories/auth_repository_impl.dart

import 'package:flutterv1/features/auth/domain/entities/user.dart';
import 'package:flutterv1/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutterv1/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:flutterv1/features/auth/data/datasources/auth_local_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remote;
  final AuthLocalDataSource _local;
  User? _current;

  AuthRepositoryImpl(this._remote, this._local);

  @override
  Future<User> loginWithEmail(String email, String password) async {
    try {
      final model = await _remote.loginWithEmail(email, password);
      _current = model.toDomain();
    } catch (_) {
      final model = await _local.loginWithEmail(email, password);
      _current = model.toDomain();
    }
    return _current!;
  }

  @override
  Future<User> loginWithPin(String id, String pin) async {
    final model = await _local.loginWithPin(id, pin);
    _current = model.toDomain();
    return _current!;
  }

  @override
  User? getCurrentUser() => _current;
}
