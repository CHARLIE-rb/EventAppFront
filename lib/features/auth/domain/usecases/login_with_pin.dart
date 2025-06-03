// lib/features/auth/domain/usecases/login_with_pin.dart

import 'package:flutterv1/features/auth/domain/entities/user.dart';
import 'package:flutterv1/features/auth/domain/repositories/auth_repository.dart';

class LoginWithPin {
  final AuthRepository _repo;
  LoginWithPin(this._repo);
  Future<User> call(String id, String pin) => _repo.loginWithPin(id, pin);
}
