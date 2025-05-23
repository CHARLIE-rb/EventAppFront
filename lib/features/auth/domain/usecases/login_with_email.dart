// lib/features/auth/domain/usecases/login_with_email.dart

import 'package:flutterv1/features/auth/domain/entities/user.dart';
import 'package:flutterv1/features/auth/domain/repositories/auth_repository.dart';

class LoginWithEmail {
  final AuthRepository _repo;
  LoginWithEmail(this._repo);
  Future<User> call(String email, String pass) =>
      _repo.loginWithEmail(email, pass);
}
