// lib/features/auth/data/datasources/auth_remote_data_source.dart

import 'package:flutterv1/features/auth/data/models/user.dart';

abstract class AuthRemoteDataSource {
  // Future<UserModel> loginWithEmail(String email, String password);
  Future<User> loginWithEmail(String email, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  // Future<UserModel> loginWithEmail(String email, String password) async {
  Future<User> loginWithEmail(String email, String password) async {
    // TODO: reemplazar por llamada HTTP cuando tengas backend
    // Por ahora, lanza excepción para simular fallo o retorna un mock
    throw UnimplementedError();
  }
}
