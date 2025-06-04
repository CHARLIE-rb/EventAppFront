// lib/features/auth/domain/repositories/auth_repository.dart

import 'package:flutterv1/shared/domain/entities/user.dart';

abstract class AuthRepository {
  Future<bool> loginWithEmail(String email, String password);
  Future<bool> loginWithPin(String id, String pin);
  Future<bool> register(User user);
}
